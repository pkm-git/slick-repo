<!-- Begin: ProcessSignUp.jsp -->
<%@ page import="java.sql.*, java.util.*, shared.*" %>
<%
   Statement statement = null;
   ResultSet rs = null;
 
   Connection connection = DBUtils.getConnection();
   
   statement = connection.createStatement();
     
   String username = request.getParameter("USERNAME");      
   String password = request.getParameter("PASSWORD");
   String confPassword = request.getParameter("PASSWORDCONF");
   String emailAddr = request.getParameter("EMAILADDR");
   String phoneCountryCode = request.getParameter("PHONE_NBR_CTRY_CODE");
   String phoneNbr = request.getParameter("PHONE_NBR");

   String firstName = request.getParameter("FIRSTNAME");
   String lastName= request.getParameter("LASTNAME");

   String zip = request.getParameter("ZIP");
   String countryCodePlusDesc = request.getParameter("COUNTRY");
   
   System.out.println(" ***** Process Sign Up: countryCodePlusDesc: " + countryCodePlusDesc);

   String[] tokens = countryCodePlusDesc.split("_");
   String countryCode = tokens[0];
   String countryName = tokens[1];  
   // String metroArea = request.getParameter("METROAREA");
   
   if (firstName == null) firstName = "";
   if (lastName == null) lastName = "";
   if (zip == null) zip = "";

   boolean found = false;

   rs = statement.executeQuery("SELECT * FROM user where username = '" + username + "'");

   while (rs.next())
   {
      found = true;
      break;
   }

   if (found)
   {
      response.sendRedirect("Register.jsp?error=errorUsernameTaken");
   }
   else if (emailAddr.indexOf('@') == -1)
   {
      response.sendRedirect("Register.jsp?error=emailInvalid");
   }
   else
   {
      rs = statement.executeQuery("SELECT * FROM contact where email_addr = '" + emailAddr + "'");

      while (rs.next())
      {
         found = true;
         break;
      }

      if (found)
      {
         response.sendRedirect("Register.jsp?error=errorEmailAlreadyRegistered");
      }
      else if (password != null && password != "" && confPassword != null)
      {
         if (!password.equals(confPassword))
            response.sendRedirect("Register.jsp?error=errorPsswd");
         else
         {
            int userId = 0;
           
            String sqlInsertUser
                    = "insert into user (username, password, date_created, date_last_login, is_enabled) values ('"      
                       + username + "', '" + password + "', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1)";

            System.out.println(" insert user = " + sqlInsertUser);
            statement.executeUpdate(sqlInsertUser);

            // Insert into Contact
            rs = statement.executeQuery("SELECT max(user_id) FROM user");

            while (rs.next())
            {
               userId = rs.getInt("max(user_id)");
            }

            String sqlInsertContact
                    = "insert into contact (user_id, email_addr, phone_country_code, phone_nbr, first_name, last_name, " +
                      "zip_code, country_code, country_name) values ("      
                       + userId + ", '" + emailAddr + "', '" + phoneCountryCode + "', '" + phoneNbr
      + "','" + firstName + "', '" + lastName
                       + "', '" + zip + "', '" + countryCode + "','" + countryName + "')";

            statement.executeUpdate(sqlInsertContact);

            int rewards = 0;

            rs = statement.executeQuery("SELECT event_rewards FROM reward_event_lookup where reward_event_pk = " + 101);

            while (rs.next())
            {
               rewards = rs.getInt("event_rewards");
               break;
            }

            String sqlInsertUserRewards
                    = "insert into user_rewards (user_id, reward_event_pk," +
                      "total_rewards_points_this_event, date_rewards_event) values (" + userId
                      + ", 101," + rewards + ",CURRENT_TIMESTAMP)";

            statement.executeUpdate(sqlInsertUserRewards);

            // Update rewards records if someone else referred me
            String sqlGetReferEmail = "SELECT * FROM refer_user where referred_email_addr = '" + emailAddr + "';";

            rs = statement.executeQuery(sqlGetReferEmail);
           
            found = false;
            int referUserId = 0;

            while (rs.next())
            {
               referUserId = rs.getInt("user_id");
               found = true;
               break;
            }
           
            if (found) // somone referred me
            {
               String sqlUpdateUser = "update user set referrer_user_id=" + referUserId + " where user_id = " + userId;

               statement.executeUpdate(sqlUpdateUser);

               String sqlUpdateReferUser = "update refer_user set has_referred_signed_up=1" +
                          ", date_referred_signed_up=CURRENT_TIMESTAMP where referred_email_addr = '" + emailAddr + "';";

               statement.executeUpdate(sqlUpdateReferUser);

               // Update user_rewards to update the rewards for the user who referred me
               rewards = 0;

               rs = statement.executeQuery("SELECT event_rewards FROM reward_event_lookup where reward_event_pk = " + 102);

               while (rs.next())
               {
                  rewards = rs.getInt("event_rewards");
                  break;
               }

               sqlInsertUserRewards
                       = "insert into user_rewards (user_id, referred_user_id," +
                         "reward_event_pk,total_rewards_points_this_event, date_rewards_event) values ("
                         + referUserId + "," + userId + ",102," + rewards + ", CURRENT_TIMESTAMP)";

               statement.executeUpdate(sqlInsertUserRewards);
               
               int userRewardId = 0;      
               rs = statement.executeQuery("SELECT max(user_reward_id) FROM user_rewards");

               while (rs.next())
               {
                  userRewardId = rs.getInt("max(user_reward_id)");
               }
               
               String sqlInsertUserRewardsEventDetail;

               if (emailAddr.contains("@"))
                  sqlInsertUserRewardsEventDetail        
                   = "insert into user_rewards_event_detail (user_reward_id, referred_user_id," +
                    " referred_email_addr) values ("
                    + userRewardId + "," + userId + ",'" + emailAddr + "');";
               else
                   sqlInsertUserRewardsEventDetail        
                    = "insert into user_rewards_event_detail (user_reward_id, referred_user_id," +
                     " referred_phone_nbr) values ("
                     + userRewardId + "," + userId + ",'" + emailAddr + "');";

               statement.executeUpdate(sqlInsertUserRewardsEventDetail);
            } // if (found) // somone referred me..

            session.removeAttribute("USERID");
            session.removeAttribute("USERNAME");
            session.removeAttribute("COUNTRYCODE");
            session.removeAttribute("COUNTRYNAME");
            // session.removeAttribute("METROAREA");
            session.removeAttribute("EMAILADDR");
            session.removeAttribute("PH_CTRY_CODE");
            session.removeAttribute("PH_NBR");

            System.out.println("************** setting user id in session = " + userId );

            session.setAttribute("USERID", new Integer(userId));
            session.setAttribute("EMAILADDR", emailAddr);
            session.setAttribute("USERNAME", username);
            session.setAttribute("COUNTRYCODE", countryCode);
            session.setAttribute("COUNTRYNAME", countryName);
            // session.setAttribute("METROAREA", new Integer(metroArea));
            session.setAttribute("PH_CTRY_CODE", phoneCountryCode);
            session.setAttribute("PH_NBR", phoneNbr);

            String msg  = "Congratulations!  You are now successfully registered at Rewards2Connect.com; your username is: "
                           + username + ".\n\nYou can now begin your connection and rewards journey by:\n* adding stores and restaurants that you plan to go and get checkout discount bar-codes in various categories\n* Posting your skills and/or resume\n* Using messenger to send/receive messages, and much more!!\n\n AND earn rewards for each such action!";

            msg += "\n\nWelcome aboard!\n\nSincerely,\n\nadmin@rewards2connect.com";

            EmailSender.sendEmail(emailAddr, "Successful registration at Rewards2Connect.com", msg);

            response.sendRedirect("SignUpSuccess.jsp");
         } // if (!password.equals(confPassword))..
      } // if (found)..
   } // if (found)..
%>
