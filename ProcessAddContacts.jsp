<!-- Begin: ProcessAddContacts.jsp -->
<%@ page import="java.sql.*, java.util.*, shared.*" %>
<%
   Statement statement = null;
   ResultSet rs = null;
  
   Connection connection = DBUtils.getConnection();
   
   statement = connection.createStatement();
     
   String contactEmailAddrs[] = request.getParameterValues("CONTACT_EMAILADDR");
   String contactPhCtryCodes[] = request.getParameterValues("CONTACT_PHONE_NBR_CTRY_CODE");
   String contactPhNbrs[] = request.getParameterValues("CONTACT_PHONE_NBR");
   String contactNames[] = request.getParameterValues("CONTACT_NAME");

   int userId = 0;

   Integer intUserId = (Integer)session.getAttribute("USERID");

   String emailAddr = (String)session.getAttribute("EMAILADDR");
   String phNbr = (String)session.getAttribute("PH_NBR");

   String firstName = "", lastName = "";

   if (intUserId != null)
   {
      userId = intUserId.intValue(); 

      String strGetContact = "SELECT * FROM contact where user_id = " + userId;
      rs = statement.executeQuery(strGetContact);
      while (rs.next())
      {
         firstName = rs.getString("first_name");
         lastName = rs.getString("last_name");
      }

      int rewards = 0;

      rs = statement.executeQuery("SELECT event_rewards FROM reward_event_lookup where reward_event_pk = " + 103);

      while (rs.next())
      {
         rewards = rs.getInt("event_rewards");
         break;
      }
      
      if ((contactEmailAddrs != null && contactEmailAddrs.length>0) ||
          (contactPhNbrs != null && contactPhNbrs.length > 0))
      {
         // Other emails contacted by me: 
         String sqlInsertContactEmail = "";
         List<String> successContactEmailList = new ArrayList<String>();
         List<String> existingUserList = new ArrayList<String>();
         
         boolean foundExistingUser = false;
         
         for (int i = 0; i < contactEmailAddrs.length; i++)
         {
             foundExistingUser = false;

             if ((contactEmailAddrs[i] != null && !contactEmailAddrs[i].equals("") && !contactEmailAddrs[i].equals("null") && !contactEmailAddrs[i].equalsIgnoreCase(emailAddr)) ||
                 (contactPhNbrs[i] != null && !contactPhNbrs[i].equals("") && !contactPhNbrs[i].equals("null") && !contactPhNbrs[i].equalsIgnoreCase(phNbr)))
             {
                // System.out.println(" i: " + i + ", contactEmailAddrs[i]: " + contactEmailAddrs[i]);

                if (!contactEmailAddrs[i].equals(""))
                {
                   sqlInsertContactEmail = "insert into user_contact (user_id, contact_name, contact_email_addr, date_contact_added) values (" +
                                         userId + ", '" + contactNames[i] + "','" + contactEmailAddrs[i] + "', CURRENT_TIMESTAMP )";
                   // EmailSender.sendEmail(contactEmailAddrs[i], "Your friend/relative contacterred you to Rewards2Connect.com", contactMsg);
                }
                else if (!contactPhCtryCodes[i].equals("") && !contactPhNbrs[i].equals(""))
                { 
                   sqlInsertContactEmail = "insert into user_contact (user_id, contact_phone_country_code, contact_phone_nbr, date_contact_added) values (" +
                                         userId + ", '" + contactNames[i] + "','" + contactPhCtryCodes[i] + "','" + contactPhNbrs[i] + "', CURRENT_TIMESTAMP )";
                   // Send text msg..
                }

                statement.executeUpdate(sqlInsertContactEmail);
             } // if (contactEmailAddrs[i] != null..
         } // for (int i = 0; i < 4; i++)..
         // *************** END: REFERRER EMAIL STUFF FROM TTC-BOY ********************
         
         /*      
         String msg  = "Awesome!"; 

         if (successContactEmailList.size()>0)
         {
            session.setAttribute("SUCCESS_EMAIL_CONTACT_LIST", successContactEmailList);

            msg += "\n\nYou successfully added the following friend(s)/relative(s) of yours today:\n\n";

            for (int i = 0; i < successContactEmailList.size(); i++)
            {
               msg += successContactEmailList.get(i) + "\n";
            }
            
            String sqlInsertUserRewards
                    = "insert into user_rewards (user_id, reward_event_pk, total_rewards_points_this_event, date_rewards_event) values ("
                      + userId + ",103," + (rewards * successContactEmailList.size()) + ", CURRENT_TIMESTAMP)";

            statement.executeUpdate(sqlInsertUserRewards);
         }

         if (existingUserList.size()>0)
         {
            session.setAttribute("EXISTING_USER_EMAIL_CONTACT_LIST", existingUserList);

            msg += "\n\nYou could not contacter the following friend(s)/relative(s) of yours today because they are existing users at Rewards2Connect.com:\n\n";

            for (int i = 0; i < existingUserList.size(); i++)
            {
               msg += existingUserList.get(i) + "\n";
            }
         }

         msg += "\n\nSincerely,\n\nceo@rewards2connect.com";
         */

         // EmailSender.sendEmail(emailAddr, "Contactrals at Rewards2Connect.com", msg);

         response.sendRedirect("ListMyContacts.jsp?state=success");
      } // if (contactEmailAddrs != null)..
   }
   else
   {
      response.sendRedirect("AddContacts.jsp?error=notSignedIn");
   } // if (intUserId != null)..
%>
<!-- End: ProcessSignUp.jsp -->

