<jsp:include page="../Header.jsp?folderLevelDown=1"/>
<%@ page import="java.sql.*, shared.*, java.util.*" %>
<%
   Statement statement = null;
   Statement statement2 = null;
   ResultSet rs = null;
   ResultSet rs2 = null;
   
   Connection connection = DBUtils.getConnection();
   statement = connection.createStatement();
   statement2 = connection.createStatement();

   System.out.println("*************** in List My Contacts jsp ");
   
   int userId = 0;

   Integer intUserId = (Integer)session.getAttribute("USERID");

   List userContactList = new ArrayList();
   UserContact userContact;

   String phoneCountryCode = (String)session.getAttribute("PH_CTRY_CODE");
   if (phoneCountryCode == null) phoneCountryCode = "+1";

   if (intUserId != null)
   {
      System.out.println("*********** user id in session = " + intUserId);
      userId = intUserId.intValue();

      // String sqlSelectUserContacts = "select * from user_contact uc, user u where uc.user_id = u.user_id and uc.user_id = " + userId + " order by uc.date_contact_added desc";
      String sqlSelectUserContacts = "select * from user_contact where user_id = " + userId + " order by date_contact_added desc";

      System.out.println(" **** sqlSelectUserContacts: " + sqlSelectUserContacts);

      rs = statement.executeQuery(sqlSelectUserContacts);
      boolean found = false;

      int intIsWhatsappUser = 0;

      while (rs.next())
      {
         userContact = new UserContact();
         userContact.userContactId = rs.getInt("user_contact_id");
         userContact.userId = rs.getInt("user_id");
         userContact.contactUserId = rs.getInt("contact_user_id");
         
         userContact.contactName = rs.getString("contact_name");
         userContact.contactEmailAddr = rs.getString("contact_email_addr");
         
         System.out.println(" **** added contactEmailAddr ");

         userContact.contactPhoneCtryCode = rs.getString("contact_phone_country_code");
         
         System.out.println(" **** added contactPhoneCtryCode ");

         userContact.contactPhoneNbr = rs.getString("contact_phone_nbr");
         
         System.out.println(" **** added contactPhoneNbr ");

         userContact.dateContactAdded = DateUtils.format(rs.getString("date_contact_added"), true);
         intIsWhatsappUser = rs.getInt("is_whatsapp_user");
         userContact.isWhatsappUser = intIsWhatsappUser == 1? true:false;
         
         System.out.println(" **** added isWhatsappUser ");
         
         String sqlSelectUser = "select * from user u, contact c where u.user_id = c.user_id ";
         
         if (userContact.contactEmailAddr != null)
         {
            sqlSelectUser += "and email_addr='" + userContact.contactEmailAddr + "'";
         }
         else if (userContact.contactPhoneCtryCode != null && userContact.contactPhoneNbr != null)
         {
            sqlSelectUser += "and phone_country_code='" + userContact.contactPhoneCtryCode + "' and phone_nbr='" + userContact.contactPhoneNbr + "'";
         }

         System.out.println(" **** sqlSelectUser: " + sqlSelectUser);

         rs2 = statement2.executeQuery(sqlSelectUser);

         while (rs2.next())
         {
             found = true;
             userContact.dateContactSignedUp = DateUtils.format(rs2.getString("date_registered"), true);
             break;
         }
         
         System.out.println(" **** created userContact obj ");

         // String sqlSelectReferUser = "select * from refer_user ru, user_contact uc where ru.user_id = uc.user_id and ru.user_id = " + userId + " and (ru.referred_email_addr = uc.contact_email_addr or (ru.referred_phone_country_code = uc.contact_phone_country_code and ru.referred_phone_nbr = uc.contact_phone_nbr))";
         String sqlSelectReferUser = "select * from refer_user where user_id = " + userId;
         
         if (userContact.contactEmailAddr != null)
         {
            sqlSelectReferUser += " and referred_email_addr = " + userContact.contactEmailAddr;
             
         }
         else if (userContact.contactPhoneCtryCode != null && userContact.contactPhoneNbr != null)
         {
            sqlSelectReferUser += "referred_phone_country_code = " + userContact.contactPhoneCtryCode
                                  + " and referred_phone_nbr = " + userContact.contactPhoneNbr;
         }

         System.out.println(" **** sqlSelectReferUser: " + sqlSelectReferUser);
         rs2 = statement2.executeQuery(sqlSelectUserContacts);

         while (rs2.next())
         {
             found = true;
             break;
         }
         if (found) userContact.didIRefer = true;

         if (userContact.contactEmailAddr == null) userContact.contactEmailAddr = "";
         if (userContact.contactPhoneNbr == null) userContact.contactPhoneNbr = "";
         
         userContactList.add(userContact);
      }
      
      System.out.println(" **** userContactList.size(): " + userContactList.size());

      session.setAttribute("USERCONTACTLIST", userContactList);
   }
%>
   <br>

   <table width="80%"  border="0"  cellspacing="6" cellpadding="6" align="center">
      <TR CLASS="JOLButtonInTDWithBorder">
         <td width="2%" valign="top"><img src="../images/spacer.gif" height="5" style="display:block"></td>
         <TD width="50%" style="white-space:nowrap;" CLASS="chapterHeader">&nbsp;My Contacts</TD>

         <td width="6%" valign="top">&nbsp;</td>
         <TD style="white-space:nowrap;"><img src="../images/spacer.gif" height="6" style="display:block"><a HREF="AddContacts.jsp">Add Contact(s)</A></TD>

         <td width="6%" valign="top">&nbsp;</td>
         <TD style="white-space:nowrap;"><img src="../images/spacer.gif" height="6" style="display:block"><a HREF="ListMyReferrals.jsp">My Referrals</A></TD>

         <td width="6%" valign="top">&nbsp;</td>
         <TD style="white-space:nowrap;"><img src="../images/spacer.gif" height="6" style="display:block"><a HREF="ViewProfile.jsp">View Profile</A></TD>
      </TR>
   </table>
   <br>

   <TABLE WIDTH=100%>
      <tr>
         <td width=1%></td>
         <td>
            <TABLE border=0 WIDTH=100%>
               <tr>
                  <td width=1% ></td>
                  <td class="blackBorder">
                     <table width="100%" cellpadding="1" cellspacing="8" border="0" CLASS="DefaultTextWhiteBackground">
                        <tr class="sectionHeader">
                           <td width=10%>Name</td>
                           <td width=20%>Email</td>
                           <td style="white-space:nowrap;" width=20%>Phone Nbr</td>
                           <td style="white-space:nowrap;" width=20%>Date Added</td>
                           <td style="white-space:nowrap;" width=10%>Did I refer to R2C?</td>
                           <td style="white-space:nowrap;" width=10%>R2C User?</td>
                           <td style="white-space:nowrap;">Date Signed Up</td>
                        </tr>
                        <%
                           String rowClass = "sectionHeader6";
                           String isR2CUser = "No";

                           if (userContactList.size() == 0)
                           {
                        %>
                             <tr class="<%= rowClass %>"><td colspan=7>&nbsp;No contacts added yet.</td></tr>
                        <%
                           }
                           else
                           {
                              for (int i=0; i < userContactList.size(); i++)
                              {
                                 userContact = (UserContact)userContactList.get(i);
                           %>
                                 <tr class="<%= rowClass %>">
                                    <TD style="white-space:nowrap;"><%= userContact.contactName %></td>
                                    <TD style="white-space:nowrap;"><%= userContact.contactEmailAddr %></td>
                                    <TD style="white-space:nowrap;"><%= (userContact.contactPhoneCtryCode + userContact.contactPhoneNbr) %></td>
                                    <TD style="white-space:nowrap;"><%= userContact.dateContactAdded %></td>
                                    <TD style="white-space:nowrap;"><%= (userContact.didIRefer? "Yes":"No") %></td>
                                    
                                    <TD style="white-space:nowrap;"><%= (userContact.contactUserId != 0? "Yes":"No") %></td>
                                    <TD style="white-space:nowrap;"><%= userContact.dateContactSignedUp %></td>
                                 </tr>
                           <%
                                 if (rowClass.equals("sectionHeader5"))
                                     rowClass = "sectionHeader6";
                                 else rowClass = "sectionHeader5";
                              } //for (int i=0; i < userContactList.size(); i++)..
                           }
                        %>
                     </table>
                  </td>
               </tr>
            </table>
        </td>
     </tr>
  </table>
  
<script language="javascript">
var add_indx = 0;
function add()
{
   add_indx = add_indx + 1;

   contacts = document.getElementsByClassName("contact");

   for (i = 0; i < contacts.length && i < add_indx; i++)
   {
      if (contacts[i].style.display == "none")
      {
         contacts[i].style.display = "block";
      }
   }  
}
</script>
  
<jsp:include page="../Footer.jsp?folderLevelDown=1"/>
