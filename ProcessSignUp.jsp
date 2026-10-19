<!-- Begin: ProcessSignUp.jsp -->
<%@ page import="java.sql.*, java.util.*, shared.*" %>
<%
   Statement statement = null;
   ResultSet rs = null;
 
   Connection connection = DBUtils.getConnection();
   
   statement = connection.createStatement();
     
   String countryCodePlusDesc = request.getParameter("COUNTRY");
   
   System.out.println(" ***** Process Sign Up: countryCodePlusDesc: " + countryCodePlusDesc);

   String businessName = request.getParameter("BUSINESS_NAME");
   String businessURL = request.getParameter("BUSINESS_URL");
   
   String strGrpCatId = request.getParameter("GRP_CATEGORY_DD");
   String strCatId = request.getParameter("CATEGORY_DD");
   
   System.out.println(" ******************************************** ");
   System.out.println(" **** PROCESS SIGN UP.JSP ******");
   System.out.println(" **** strGrpCatId: " + strGrpCatId + ", strCatId: " + strCatId);

   int grpCatId = 0;
   int catId = 0;

   if (strGrpCatId != null)
   {
      grpCatId = Integer.parseInt(strGrpCatId);
   }
   
   if (strCatId != null)
   {
      catId = Integer.parseInt(strCatId);
   }

   System.out.println(" ***** Process Sign Up: grpCatId: " + grpCatId + ", catId: " + catId);

   String referCode = request.getParameter("REFER_CODE");
   
   if (businessName == null) businessName = "";
   else if (businessName.contains("'"))
   {
      businessName = businessName.replace("'", "''");
   }

   if (businessURL == null) businessURL = "";

   String username = request.getParameter("USERNAME");      
   String password = request.getParameter("PASSWORD");
   String confPassword = request.getParameter("PASSWORDCONF");
   String emailAddr = request.getParameter("EMAILADDR");
   String phoneCountryCode = request.getParameter("PHONE_NBR_CTRY_CODE");
   String phoneNbr = request.getParameter("PHONE_NBR");

   String firstName = request.getParameter("FIRSTNAME");
   String lastName= request.getParameter("LASTNAME");

   String addrLine1= request.getParameter("ADDR_LINE1");
   String addrLine2= request.getParameter("ADDR_LINE2");
   String addrLine3= request.getParameter("ADDR_LINE3");
   String city = request.getParameter("CITY");
   String state = request.getParameter("STATE");
   String zip = request.getParameter("ZIP");

   String[] tokens = countryCodePlusDesc.split("_");
   String countryCode = tokens[0];
   String countryName = tokens[1];  
   // String metroArea = request.getParameter("METROAREA");
   
   if (firstName == null) firstName = "";
   if (lastName == null) lastName = "";
   if (zip == null) zip = "";
   
   if (emailAddr == null) emailAddr = "";
   if (phoneNbr == null) phoneNbr = "";
   
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
   else
   {
      if (!emailAddr.equals(""))
      {
         if (emailAddr.indexOf('@') == -1)
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
         } // if (emailAddr.indexOf('@') == -1)..
      } // if (!emailAddr.equals(""))..

      if (found)
      {
         response.sendRedirect("Register.jsp?error=errorEmailAlreadyRegistered");
      }
      else
      {
         if (!phoneNbr.equals(""))
         {
            rs = statement.executeQuery("SELECT * FROM contact where phone_nbr = '" + phoneNbr + "'");

            while (rs.next())
            {
               found = true;
               break;
            }
         }

         if (found)
         {
            response.sendRedirect("Register.jsp?error=errorPhoneNbrAlreadyRegistered");
         }
         else if (password != null && password != "" && confPassword != null)
         {
            if (!password.equals(confPassword))
               response.sendRedirect("Register.jsp?error=errorPsswd");
         
            else if (!businessName.equals(""))
            {
               int businessId = 0;

               String sqlInsertBusiness
                                = "insert into business (business_name, business_url, group_cat_id, cat_id, username, password, "
                                  + "email_addr, phone_country_code, phone_nbr, country_code, country_name, address1, address2, "
                                  + "address3, city, state, zip_code, date_registered, date_last_login, is_enabled, is_HQ, is_active) values ('"      
                                  + businessName + "', '" + businessURL + "'," + grpCatId + "," + catId + ",'" + username + "', '" + password
                                  + "', '" + emailAddr + "', '" + phoneCountryCode + "', '" + phoneNbr + "', '" + countryCode + "', '" + countryName
                                  + "', '" + addrLine1 + "','" + addrLine2 + "','" + addrLine3 + "','" + city + "','"
                                  + state + "','" + zip + "',CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1, 1)";

               System.out.println(" insert business = " + sqlInsertBusiness);
               statement.executeUpdate(sqlInsertBusiness);

               // Insert into business_contact table
               rs = statement.executeQuery("SELECT max(business_id) FROM business");

               while (rs.next())
               {
                  businessId = rs.getInt("max(business_id)");
               }

               session.removeAttribute("BUSINESSID");
               session.setAttribute("BUSINESSID", new Integer(businessId));

               String sqlInsertBusinessContact
                     = "insert into business_contact (business_id, email_addr, phone_country_code, phone_nbr, first_name, last_name, " +
                       "zip_code, country_code, country_name) values ("      
                        + businessId + ", '" + emailAddr + "', '" + phoneCountryCode + "', '" + phoneNbr
                     + "','" + firstName + "', '" + lastName
                        + "', '" + zip + "', '" + countryCode + "','" + countryName + "')";

               statement.executeUpdate(sqlInsertBusinessContact);

               session.removeAttribute("BUSINESSID");
               session.removeAttribute("BUSINESSNAME");
               session.removeAttribute("BUSINESSURL");
               session.removeAttribute("GROUP_CAT_ID");
               session.removeAttribute("CAT_ID");

               session.setAttribute("BUSINESSID", new Integer(businessId));
               session.setAttribute("BUSINESSNAME", businessName);
               session.setAttribute("BUSINESSURL", businessURL);
               session.setAttribute("GROUP_CAT_ID", grpCatId);
               session.setAttribute("CAT_ID", catId);
            }
            else
            {
               int userId = 0;
               
               String sqlInsertUser
                       = "insert into user (username, password, date_registered, date_last_login, is_admin, is_enabled) values ('"      
                          + username + "', '" + password + "', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 0, 1)";

               System.out.println(" insert user = " + sqlInsertUser);
               statement.executeUpdate(sqlInsertUser);

               // Insert into Contact
               rs = statement.executeQuery("SELECT max(user_id) FROM user");

               while (rs.next())
               {
                  userId = rs.getInt("max(user_id)");
               }
           
               session.removeAttribute("USERID");
               session.setAttribute("USERID", new Integer(userId));

               String sqlInsertContact
                       = "insert into contact (user_id, email_addr, phone_country_code, phone_nbr, first_name, last_name, " +
                         "zip_code, country_code, country_name) values ("      
                          + userId + ", '" + emailAddr + "', '" + phoneCountryCode + "', '" + phoneNbr
                      + "','" + firstName + "', '" + lastName
                          + "', '" + zip + "', '" + countryCode + "','" + countryName + "')";

               statement.executeUpdate(sqlInsertContact);

               /*
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
               */

               // Update rewards records if someone else referred me
               String sqlGetReferEmail = "SELECT * FROM refer_user where referred_email_addr = '" + emailAddr + "' or referred_phone_nbr = '" + phoneNbr + "';";

               rs = statement.executeQuery(sqlGetReferEmail);
               
               found = false;
               int referrerUserId = 0;

               while (rs.next())
               {
                  referrerUserId = rs.getInt("user_id");
                  found = true;
                  break;
               }
               
               if (found) // someone referred me
               {
                  String sqlUpdateUser = "update user set referrer_user_id=" + referrerUserId + " where user_id = " + userId;

                  statement.executeUpdate(sqlUpdateUser);

                  String sqlUpdateReferUser = "update refer_user set has_referred_signed_up=1" +
                             ", date_referred_signed_up=CURRENT_TIMESTAMP where referred_email_addr = '" + emailAddr + "';";

                  statement.executeUpdate(sqlUpdateReferUser);

                  // Update user_rewards to update the rewards for the user who referred me
                  int rewards = 0;

                  rs = statement.executeQuery("SELECT event_rewards FROM reward_event_lookup where reward_event_pk = " + 102);

                  while (rs.next())
                  {
                     rewards = rs.getInt("event_rewards");
                     break;
                  }

                  String sqlInsertUserRewards
                          = "insert into user_rewards (user_id, referred_user_id," +
                            "reward_event_pk,total_rewards_points_this_event, date_rewards_event) values ("
                            + referrerUserId + "," + userId + ",102," + rewards + ", CURRENT_TIMESTAMP)";

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
                        " referred_phone_nbr, referred_phone_country_code) values ("
                        + userRewardId + "," + userId + ",'" + phoneNbr + "','" + phoneCountryCode + "');";

                  statement.executeUpdate(sqlInsertUserRewardsEventDetail);
               } // if (found) // somone referred me..
            } // if (!password.equals(confPassword))..

            session.removeAttribute("USERNAME");
            session.removeAttribute("COUNTRYCODE");
            session.removeAttribute("COUNTRYNAME");
            session.removeAttribute("EMAILADDR");
            session.removeAttribute("PH_CTRY_CODE");
            session.removeAttribute("PH_NBR");

            session.setAttribute("EMAILADDR", emailAddr);
            session.setAttribute("USERNAME", username);
            session.setAttribute("COUNTRYCODE", countryCode);
            session.setAttribute("COUNTRYNAME", countryName);
            session.setAttribute("PH_CTRY_CODE", phoneCountryCode);
            session.setAttribute("PH_NBR", phoneNbr);

            String msg  = "Congratulations!  You are now successfully registered at Rewards2Connect.com; your username is: "
                        + username + ".\n\n";

            if (!businessName.equals(""))
            {
               msg += "You can now begin increasing your revenue by:\n* Adding a link to Rewards2Connect.com on your website so that your existing/new customers can generate checkout coupons specific to your business!!\n\n";
            }
            else
            {
               msg += "You can now begin getting checkout discounts and referral rewards by:\n* Adding stores and restaurants that you plan to go and get checkout discount bar-codes in various categories\n* and much more!!\n\n";
            }

            msg += "\n\nWelcome aboard!\n\nSincerely,\n\nceo@rewards2connect.com";

            EmailSender.sendEmail(emailAddr, "Successful registration at Rewards2Connect.com", msg);

            response.sendRedirect("SignUpSuccess.jsp");
         } // if (found)..
     } // if (found)..
   } // if (found)..
%>
<!-- End: ProcessSignUp.jsp -->
