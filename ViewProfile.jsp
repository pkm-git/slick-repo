<!-- Begin: ViewProfile.jsp -->
<%@ page import="java.sql.*, shared.*, shared.DateUtils" %>
<%
   Integer intUserId = (Integer)session.getAttribute("USERID");
   Integer intBusinessId = (Integer)session.getAttribute("BUSINESSID");

   String emailAddr = (String)session.getAttribute("EMAILADDR");
   String username = (String)session.getAttribute("USERNAME");
   String countryCode = (String)session.getAttribute("COUNTRYCODE");
   String countryDesc = (String)session.getAttribute("COUNTRYDESC");  
   // String phoneCtryCode = (String)session.setAttribute("PH_CTRY_CODE");
   String phoneCtryCode = "";

   int grpCatId = 0;
   int catId = 0;

   Statement statement = null;
   ResultSet rs = null;
   
   Connection connection = DBUtils.getConnection();
   statement = connection.createStatement();

   int userId = 0;
   int userType = 0;

   int businessId = 0;

   String strUserType = "";
   String strGrpCatDesc = "";
   String strCatDesc = "";

   String dateRegistered = "";
   String dateLastLogin = "";
   
   String strFirstName = "&nbsp;";
   String strLastName = "&nbsp;";

   String strBusinessName = "&nbsp;";
   String strBusinessUrl = "&nbsp;";

   String strPhoneNbr = "&nbsp;";
   String strAddress1 = "&nbsp;";
   String strAddress2 = "&nbsp;";
   String strAddress3 = "&nbsp;";
   String strCity = "&nbsp;";
   String strState = "&nbsp;";
   String strZipCode = "&nbsp;";
   String strCountryName = "&nbsp;";  

   int totalRewardsEarned = 0;
   int rewardsEarnedYTD = 0;
   int rewardsEarnedThisSession = 0;
   int rewardsEarnedLastSession = 0;
   int maxRewardsEarned = 0;
   
   if (intUserId == null && intBusinessId != null)
   {
      Integer intGrpCatId = (Integer)session.getAttribute("GROUP_CAT_ID");

      if (intGrpCatId != null)
      {
         grpCatId = intGrpCatId.intValue();
      }

      Integer intCatId = (Integer)session.getAttribute("CAT_ID");
     
      if (intCatId != null)
      {
         catId = intCatId.intValue();
      }

      String strGetGrpCat = "SELECT * FROM group_category where group_cat_id = " + grpCatId;
      rs = statement.executeQuery(strGetGrpCat);
      while (rs.next())
      {
         strGrpCatDesc = rs.getString("group_cat_desc");
         break;
      }

      String strGetCat = "SELECT * FROM category where cat_id = " + catId;
      rs = statement.executeQuery(strGetCat);
      while (rs.next())
      {
         strCatDesc = rs.getString("cat_desc");
         break;
      }

      businessId = intBusinessId.intValue();

      String strGetBusiness = "SELECT * FROM business where business_id = " + businessId;
      rs = statement.executeQuery(strGetBusiness);
      while (rs.next())
      {
         dateRegistered = rs.getString("date_registered");
         dateLastLogin = rs.getString("date_last_login");
         strBusinessName = rs.getString("business_name"); if (strBusinessName == null) strBusinessName = "";
         strBusinessUrl = rs.getString("business_url"); if (strBusinessUrl == null) strBusinessUrl = "";

         phoneCtryCode = rs.getString("phone_country_code"); if (phoneCtryCode == null) phoneCtryCode = "";
         strPhoneNbr = rs.getString("phone_nbr"); if (strPhoneNbr == null) strPhoneNbr = "";
         strAddress1 = rs.getString("address1"); if (strAddress1 == null) strAddress1 = "";
         strAddress2 = rs.getString("address2"); if (strAddress2 == null) strAddress2 = "";
         strAddress3 = rs.getString("address3"); if (strAddress3 == null) strAddress3 = "";
         strCity = rs.getString("city"); if (strCity == null) strCity = "";
         strState = rs.getString("state"); if (strState == null) strState = "";
         strZipCode = rs.getString("zip_code"); if (strZipCode == null) strZipCode = "";
         strCountryName = rs.getString("country_name"); if (strCountryName == null) strCountryName = "";

         break;
      }

      String strGetContact = "SELECT * FROM business_contact where business_id = " + businessId;
      rs = statement.executeQuery(strGetContact);
      while (rs.next())
      {
         strFirstName = rs.getString("first_name"); if (strFirstName == null) strFirstName = "";
         strLastName = rs.getString("last_name"); if (strLastName == null) strLastName = "";
      }
   }
   else if (intUserId != null)
   {
      strUserType = "Individual";

      System.out.println("*********** user id in session = " + intUserId);
      userId = intUserId.intValue();

      String strGetUsername = "SELECT * FROM user where user_id = " + userId;
      rs = statement.executeQuery(strGetUsername);
      while (rs.next())
      {
         dateRegistered = rs.getString("date_registered");
         dateLastLogin = rs.getString("date_last_login");
         break;
      }

      String strGetContact = "SELECT * FROM contact where user_id = " + userId;
      rs = statement.executeQuery(strGetContact);
      while (rs.next())
      {
         strFirstName = rs.getString("first_name"); if (strFirstName == null) strFirstName = "";
         strLastName = rs.getString("last_name"); if (strLastName == null) strLastName = "";
         phoneCtryCode = rs.getString("phone_country_code"); if (phoneCtryCode == null) phoneCtryCode = "";
         strPhoneNbr = rs.getString("phone_nbr"); if (strPhoneNbr == null) strPhoneNbr = "";
         strAddress1 = rs.getString("address1"); if (strAddress1 == null) strAddress1 = "";
         strAddress2 = rs.getString("address2"); if (strAddress2 == null) strAddress2 = "";
         strAddress3 = rs.getString("address3"); if (strAddress3 == null) strAddress3 = "";
         strCity = rs.getString("city"); if (strCity == null) strCity = "";
         strState = rs.getString("state"); if (strState == null) strState = "";
         strZipCode = rs.getString("zip_code"); if (strZipCode == null) strZipCode = "";
         strCountryName = rs.getString("country_name"); if (strCountryName == null) strCountryName = "";
      }

      String strGetTotalRewards = "SELECT sum(rel.event_rewards)" +
          " FROM user_rewards ur, reward_event_lookup rel, contact c " +
          " WHERE ur.reward_event_pk = rel.reward_event_pk and " +
          " ((ur.user_id = c.user_id and ur.referred_user_id is null) or " +
          " (ur.referred_user_id = c.user_id)) and ur.user_id=" + userId;

      rs = statement.executeQuery(strGetTotalRewards);

      while (rs.next())
      {
         totalRewardsEarned = rs.getInt("sum(rel.event_rewards)");
         break;
      }

      System.out.println(" **** FINAL dateRegistered: " + dateRegistered);
   }
   else
      response.sendRedirect("Login.jsp?status=errorNotLoggedIn");
      //response.sendRedirect("Login.jsp?status=errorTimedOut");
%>
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="../styles/styles.css" />
<SCRIPT LANGUAGE="JAVASCRIPT">
function handleModify()
{
   document.forms.main.action="ModifyProfile.jsp?user_id=" + <%= userId %>;
   document.forms.main.submit();
}
</script>
</HEAD>
<jsp:include page="../Header.jsp?folderLevelDown=1"/>
<br>
<table width=70%>
   <tr>
      <td width=60%>
         <table WIDTH=95% cellpadding="2">
            <tr>
               <td width=95%>
                   <table WIDTH=95% cellpadding="2">
                      <tr class="JOLTextInTD14pxWithBorder">
                          <td align="center">&nbsp;&nbsp;VIEW PROFILE</td>
                      </TR>
                   </TABLE>
               </td>
               <td>
                   <table WIDTH=95% cellpadding="2">
                       <tr>
                          <td align="center">
                             <form method="POST" action="ViewProfile.jsp?mode=edit">
                                <input type="image" name="submit" src="../images/edit.gif" width=26px height=26px />
                             </form>
                          </td>  
                       </tr>
                   </table>
               </td>
            </tr>
         </table>
         <br>

         <table width=95%>
            <%
              if (businessId == 0 && userId != 0)
           {
            %>  
                <TR class="sectionHeader5"><TD>User Type</TD><TD><%= strUserType %></TD></TR>
            <%
           }
           else if (businessId != 0 && userId == 0)
           {
            %>
                <TR class="sectionHeader5"><TD>Group Category/Category</TD><TD><%= (strGrpCatDesc + "/" + strCatDesc) %></TD></TR>
               
                <TR class="sectionHeader6"><TD>Business Name:</TD><TD><%= strBusinessName %></TD></TR>
                <TR class="sectionHeader5"><TD>Business URL:</TD><TD><%= strBusinessUrl %></TD></TR>

                <TR class="sectionHeader6"><TD>Address:</TD><TD><%= strAddress1 %></TD></TR>
             <%
                if (!strAddress2.equals(""))
{
             %>
                   <TR class="sectionHeader5"><TD>Address Line 2:</TD><TD><%= strAddress2 %></TD></TR>
            <%
}
                if (!strAddress3.equals(""))
{
             %>
                   <TR class="sectionHeader6"><TD>Address Line 3:</TD><TD><%= strAddress3 %></TD></TR>
            <%
}
            %>
                <TR class="sectionHeader5"><TD>City/State/Zip:</TD><TD><%= strCity %>&nbsp;<%= strState %>&nbsp;<%= strZipCode %></TD></TR>
            <%
              }

               if (!strCountryName.equals("United States"))
               {
            %>
                 <TR class="sectionHeader6"><TD>Country:</TD><TD><%= strCountryName %></TD></TR>
            <%
               }
            %>

            <TR class="sectionHeader6"><TD>First/Last Name:</TD><TD><%= strFirstName %>&nbsp;<%= strLastName %></TD></TR>
            <TR class="sectionHeader5"><TD>Email Address:</TD><TD><%= (emailAddr != null && emailAddr.equals("")? "&nbsp;": emailAddr) %></TD></TR>
            <TR class="sectionHeader6"><TD>Phone Number:</TD><TD><%= (strPhoneNbr != null && strPhoneNbr.equals("")? "&nbsp;": "(" + phoneCtryCode + ") " + strPhoneNbr) %></TD></TR>

            <TR class="sectionHeader5"><TD>Member Since:</TD><TD><%= DateUtils.format(dateRegistered, false) %></TD></TR>
            <TR class="sectionHeader6"><TD>Last Login:</TD><TD><%= DateUtils.format(dateLastLogin, true) %><img src="../images/spacer.gif" height="6" style="display:block"></TD></TR>
         </TABLE>
      </td>
   </tr>
   <tr><td><hr></td></tr>
   <tr>
      <td width=80%>
         <%
            if (businessId == 0 && userId != 0)
            {
         %>  
               <table width="80%" cellpadding="6" cellspacing="8" border="1">
                  <tr><td colspan=2><img src="../images/spacer.gif" height="14" style="display:block"></td></tr>

                  <TR CLASS="JOLButtonInTDWithBorder">
                      <TD WIDTH=4%></TD>
                      <TD style="white-space:nowrap;"><a HREF="ListParticipants.jsp?type=1">Participating Credit Card Issuers</A></TD>

                      <TD WIDTH=4%></TD>
                      <TD style="white-space:nowrap;"><a HREF="ListParticipants.jsp?type=2">Participating Stores/Restaurants</A></TD>

                      <!-- <TD WIDTH=4%></TD>
                      <TD style="white-space:nowrap;"><a HREF="ListMyContacts.jsp">My Contacts</A></TD> -->

                      <TD WIDTH=4%></TD>
                      <TD style="white-space:nowrap;"><a HREF="ListMyReferrals.jsp">My Referrals</A></TD>
                  </TR>
               </TABLE>
               <br>
         <%
          }
            else
          {
         %>
           <!--
               <table width="100%" cellpadding="6" cellspacing="8" border="1">
                  <tr><td colspan=2><img src="../images/spacer.gif" height="44" style="display:block"></td></tr>
                  <TR CLASS="JOLButtonInTDWithBorder">
                      <TD WIDTH=4%></TD>
                      <TD style="white-space:nowrap;"><a HREF="ListCustomers.jsp">Customers signed up at Rewards2Connect</A></TD>
                  </TR>
               </TABLE>
               <br>
            -->   
         <%
          }
         %>
      </td>
   </tr>
   <tr><td><hr></td></tr>
</table>


<jsp:include page="../Footer.jsp?folderLevelDown=1"/>
