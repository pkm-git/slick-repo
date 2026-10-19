<!-- Begin: ProcessSignUp.jsp -->
<%@ page import="java.sql.*, java.util.*, shared.*" %>
<%
   Statement statement = null;
   ResultSet rs = null;
  
   Connection connection = DBUtils.getConnection();
   
   statement = connection.createStatement();
     
   String refEmailAddrs[] = request.getParameterValues("REF_EMAILADDR");
   String refPhCtryCodes[] = request.getParameterValues("REF_PHONE_NBR_CTRY_CODE");
   String refPhNbrs[] = request.getParameterValues("REF_PHONE_NBR");
   String refNames[] = request.getParameterValues("REF_NAME");

   int userId = 0;
   int userLoginId = 0;

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
      
      if ((refEmailAddrs != null && refEmailAddrs.length>0) ||
          (refPhNbrs != null && refPhNbrs.length > 0))
      {
         // Other emails referred by me: 
         String sqlInsertReferEmail = "";
         List<String> successReferEmailList = new ArrayList<String>();
         List<String> alreadyReferredByOthersEmailList = new ArrayList<String>();
         List<String> existingUserList = new ArrayList<String>();
         
         boolean foundAlreadyReferredByOthers = false;
         boolean foundExistingUser = false;
         
         for (int i = 0; i < refEmailAddrs.length; i++)
         {
             foundAlreadyReferredByOthers = false;
             foundExistingUser = false;

             if ((refEmailAddrs[i] != null && !refEmailAddrs[i].equals("") && !refEmailAddrs[i].equals("null") && !refEmailAddrs[i].equalsIgnoreCase(emailAddr)) ||
                 (refPhNbrs[i] != null && !refPhNbrs[i].equals("") && !refPhNbrs[i].equals("null") && !refPhNbrs[i].equalsIgnoreCase(phNbr)))
             {
                System.out.println(" i: " + i + ", refEmailAddrs[i]: " + refEmailAddrs[i]);

                // check if an existing user has this refer email address:
                rs = statement.executeQuery("SELECT email_addr FROM contact where email_addr = '" + refEmailAddrs[i] +
                                             "' or (phone_country_code = '" + refPhCtryCodes[i] + "' and phone_nbr = '" + refPhNbrs[i] + "')");
                while (rs.next())
                {
                    foundExistingUser = true;
                    existingUserList.add(refEmailAddrs[i]);
                    break;
                }

                if (!foundExistingUser) // not an existing user's email address
                {
                   // check if this email addr was already referred by someone else:
                   String sqlSelectReferUser = "SELECT * FROM refer_user where referred_email_addr = '" +
                                                refEmailAddrs[i] + "' or (referred_phone_country_code = '" +
                                                refPhCtryCodes[i] + "' and referred_phone_nbr = '" + refPhNbrs[i] + "')";
                   
                   System.out.println(" *** sqlSelectReferUser: " + sqlSelectReferUser);

                   rs = statement.executeQuery(sqlSelectReferUser);
                   while (rs.next())
                   {
                       foundAlreadyReferredByOthers = true;
                       break;
                   }

                   if (!foundAlreadyReferredByOthers) // not already referred by others
                   {
                      // if (refEmailAddrs[i].contains("@"))
                      if (!refEmailAddrs[i].equals(""))
                      {
                         sqlInsertReferEmail = "insert into refer_user (user_id, name, referred_email_addr, date_referred) values (" +
                                               userId + ", '" + refNames[i] + "','" + refEmailAddrs[i] + "', CURRENT_TIMESTAMP )";
                         // EmailSender.sendEmail(refEmailAddrs[i], "Your friend/relative referred you to Rewards2Connect.com", refMsg);
                         successReferEmailList.add(refEmailAddrs[i]);
                      }
                      else if (!refPhCtryCodes[i].equals("") && !refPhNbrs[i].equals(""))
                      { 
                         sqlInsertReferEmail = "insert into refer_user (user_id, name, referred_phone_country_code, referred_phone_nbr, date_referred) values (" +
                                               userId + ", '" + refNames[i] + "','" + refPhCtryCodes[i] + "','" + refPhNbrs[i] + "', CURRENT_TIMESTAMP )";
                         // Send text msg..


                         successReferEmailList.add("(" + refPhCtryCodes[i] + ")");
                      }

                      statement.executeUpdate(sqlInsertReferEmail);
                   }
                   else
                   {
                      alreadyReferredByOthersEmailList.add(refEmailAddrs[i]);
                   } // if (!foundAlreadyReferredByOthers)..
                }
                else
                {
                   existingUserList.add(refEmailAddrs[i]);
                }
             } // if (refEmailAddrs[i] != null..
         } // for (int i = 0; i < 4; i++)..
         // *************** END: REFERRER EMAIL STUFF FROM TTC-BOY ********************
               
         String msg  = "Awesome!"; 

         if (successReferEmailList.size()>0)
         {
            session.setAttribute("SUCCESS_EMAIL_REFER_LIST", successReferEmailList);

            msg += "\n\nYou successfully referred the following friend(s)/relative(s) of yours today:\n\n";

            for (int i = 0; i < successReferEmailList.size(); i++)
            {
               msg += successReferEmailList.get(i) + "\n";
            }
            
            String sqlInsertUserRewards
                    = "insert into user_rewards (user_id, reward_event_pk, total_rewards_points_this_event, date_rewards_event) values ("
                      + userId + ",103," + (rewards * successReferEmailList.size()) + ", CURRENT_TIMESTAMP)";

            statement.executeUpdate(sqlInsertUserRewards);
         }

         if (existingUserList.size()>0)
         {
            session.setAttribute("EXISTING_USER_EMAIL_REFER_LIST", existingUserList);

            msg += "\n\nYou could not refer the following friend(s)/relative(s) of yours today because they are existing users at Rewards2Connect.com:\n\n";

            for (int i = 0; i < existingUserList.size(); i++)
            {
               msg += existingUserList.get(i) + "\n";
            }
         }

         if (alreadyReferredByOthersEmailList.size()>0)
         {
            session.setAttribute("ALREADY_REFERRED_EMAIL_LIST", alreadyReferredByOthersEmailList);

            msg += "\n\nYou could not refer to the following friend(s)/relative(s) of yours today because they have already been referred by others:\n\n";

            for (int i = 0; i < alreadyReferredByOthersEmailList.size(); i++)
            {
               msg += alreadyReferredByOthersEmailList.get(i) + "\n";
            }
         }

         msg += "\n\nSincerely,\n\nceo@rewards2connect.com";

         // EmailSender.sendEmail(emailAddr, "Referrals at Rewards2Connect.com", msg);

         response.sendRedirect("ReferMoreSuccess.jsp");
      } // if (refEmailAddrs != null)..
   }
   else
   {
      response.sendRedirect("ReferMore.jsp?error=noReferrals");
   } // if (intUserId != null)..
%>
<!-- End: ProcessSignUp.jsp -->

