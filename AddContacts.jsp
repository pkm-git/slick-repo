<%@ page import="java.sql.*, java.util.*, shared.*" %>
<%
    String phoneCountryCode = (String)session.getAttribute("PH_CTRY_CODE");
    if (phoneCountryCode == null) phoneCountryCode = "+1";

    // VonageSendSms.sendSms("+12489461570");
%>
<html>
<head>
<title>Rewards2Connect.com - Add contacts</title>
<SCRIPT LANGUAGE="JAVASCRIPT">
function validate()
{
   var found = false;

   emailAddrs = document.getElementsByClassName("emailAddr");
   
   for (i = 0; i < emailAddrs.length; i++)
   {
       if (emailAddrs[i].value != "")
       {
          found = true;
          break;
       } // if (emailAddrs[i].value != "")..
   } // for (i = 0; i < emailAddrs.length; i++)..
   
   phCtryCodes = document.getElementsByClassName("phNbrCtryCode");
   phNbrs = document.getElementsByClassName("phNbr");

   for (i = 0; i < phCtryCodes.length; i++)
   {
       if (phCtryCodes[i].value != "" && phNbrs[i].value != ""
           && phNbrs[i].value.startsWith('+'))
       {
          found = true;
          break;
       } // if (phCtryCodes[i].value != ""..
   } // for (i = 0; i < phCtryCodes.length; i++)..

   if (!found)
   {
      alert("You must enter at least one contact's email address OR phone number with a country code starting with + sign.");
      return false;
   }
       
   return true;
}
</script>
</head>

<jsp:include page="../Header.jsp?folderLevelDown=1"/>

   <table width="60%"  border="0"  cellspacing="6" cellpadding="6" align="center">
      <TR CLASS="JOLButtonInTDWithBorder">
         <TD width="50%" style="white-space:nowrap;" CLASS="chapterHeader">&nbsp;Add Contact(s)</TD>

         <td width="6%" valign="top">&nbsp;</td>
         <TD style="white-space:nowrap;"><img src="../images/spacer.gif" height="6" style="display:block"><a HREF="ListMyReferrals.jsp">My Referrals</A></TD>

         <td width="6%" valign="top">&nbsp;</td>
         <TD style="white-space:nowrap;"><img src="../images/spacer.gif" height="6" style="display:block"><a HREF="ViewProfile.jsp">View Profile</A></TD>
      </TR>
   </table>
   <br>
   
   <table width="60%">
      <tr>
         <td>
             Please enter contact info (either Email Address or Phone Number [with country code] or both) of your friends/relatives here (up to 10 at a time)..
         </td>
      </tr>
   </table>           
   <br>
   
   <form onSubmit="onSubmitAction()" name="mainForm" method="POST" action="ProcessAddContacts.jsp">
      <TABLE WIDTH=60%>
         <tr>
            <td width=1%></td>
            <td>
               <table width="100%" cellpadding="2" cellspacing="2" border="0" CLASS="DefaultTextWhiteBackground">
                  <tr class="sectionHeader">
                     <td width=2% style="text-align: center;">&nbsp;#&nbsp;</td>
                     <td width=10% style="text-align: center;">&nbsp;Name</td>
                     <td width=20% style="text-align: center;">Email</td>
                     <td style="white-space:nowrap;text-align: center;" width=20%>Phone Nbr</td>
                  </tr>
                  <%
                     String rowClass = "sectionHeader6";
                  %>
                  
                  <tr><td colspan=4><img src="../images/spacer.gif" height="6" style="display:block"></td></tr>
                  
                  <tr class='sectionHeader5'>
                     <td width=2% style="text-align:center;vertical-align:center;">&nbsp;1&nbsp;</td>
                     <TD><input type="text" name="CONTACT_NAME" size="10" maxlength="20"/></td>
                     <TD><input class="emailAddr" type="text" name="CONTACT_EMAILADDR" size="20" maxlength="80"/></td>
                     <TD style="vertical-align:top;">
                         <table>
                            <tr>
                               <td><input class="phNbrCtryCode" type="text" name="CONTACT_PHONE_NBR_CTRY_CODE" value="<%= phoneCountryCode %>" class="txtfld" size="2" maxlength="4"/></td>
                               <TD><input class="phNbr" type="text" name="CONTACT_PHONE_NBR" class="txtfld" value="" size="15" maxlength="20"/></td>
                            </tr>
                         </table>
                     </td>
                  </TR>

                  <tr class='sectionHeader6'>
                     <td width=2% style="text-align:center;vertical-align:center;">&nbsp;2&nbsp;</td>
                     <TD><input type="text" name="CONTACT_NAME" size="10" maxlength="20"/></td>
                     <TD><input class="emailAddr" type="text" name="CONTACT_EMAILADDR" size="20" maxlength="80"/></td>
                     <TD style="vertical-align:top;">
                         <table>
                            <tr>
                               <td><input class="phNbrCtryCode" type="text" name="CONTACT_PHONE_NBR_CTRY_CODE" value="<%= phoneCountryCode %>" class="txtfld" size="2" maxlength="4"/></td>
                               <TD><input class="phNbr" type="text" name="CONTACT_PHONE_NBR" class="txtfld" value="" size="15" maxlength="20"/></td>
                            </tr>
                         </table>
                     </td>
                  </TR>

                  <tr class='sectionHeader5'>
                     <td width=2% style="text-align:center;vertical-align:center;">&nbsp;3&nbsp;</td>
                     <TD><input type="text" name="CONTACT_NAME" size="10" maxlength="20"/></td>
                     <TD><input class="emailAddr" type="text" name="CONTACT_EMAILADDR" size="20" maxlength="80"/></td>
                     <TD style="vertical-align:top;">
                         <table>
                            <tr>
                               <td><input class="phNbrCtryCode" type="text" name="CONTACT_PHONE_NBR_CTRY_CODE" value="<%= phoneCountryCode %>" class="txtfld" size="2" maxlength="4"/></td>
                               <TD><input class="phNbr" type="text" name="CONTACT_PHONE_NBR" class="txtfld" value="" size="15" maxlength="20"/></td>
                            </tr>
                         </table>
                     </td>
                  </TR>

                  <tr class='sectionHeader6'>
                     <td width=2% style="text-align:center;vertical-align:center;">&nbsp;4&nbsp;</td>
                     <TD><input type="text" name="CONTACT_NAME" size="10" maxlength="20"/></td>
                     <TD><input class="emailAddr" type="text" name="CONTACT_EMAILADDR" size="20" maxlength="80"/></td>
                     <TD style="vertical-align:top;">
                         <table>
                            <tr>
                               <td><input class="phNbrCtryCode" type="text" name="CONTACT_PHONE_NBR_CTRY_CODE" value="<%= phoneCountryCode %>" class="txtfld" size="2" maxlength="4"/></td>
                               <TD><input class="phNbr" type="text" name="CONTACT_PHONE_NBR" class="txtfld" value="" size="15" maxlength="20"/></td>
                            </tr>
                         </table>
                     </td>
                  </TR>

                  <tr class='sectionHeader5'>
                     <td width=2% style="text-align:center;vertical-align:center;">&nbsp;5&nbsp;</td>
                     <TD><input type="text" name="CONTACT_NAME" size="10" maxlength="20"/></td>
                     <TD><input class="emailAddr" type="text" name="CONTACT_EMAILADDR" size="20" maxlength="80"/></td>
                     <TD style="vertical-align:top;">
                         <table>
                            <tr>
                               <td><input class="phNbrCtryCode" type="text" name="CONTACT_PHONE_NBR_CTRY_CODE" value="<%= phoneCountryCode %>" class="txtfld" size="2" maxlength="4"/></td>
                               <TD><input class="phNbr" type="text" name="CONTACT_PHONE_NBR" class="txtfld" value="" size="15" maxlength="20"/></td>
                            </tr>
                         </table>
                     </td>
                  </TR>

                  <tr class="sectionHeader6">
                     <td width=2% style="text-align:center;vertical-align:center;">&nbsp;6&nbsp;</td> 
                     <TD><input type="text" name="CONTACT_NAME" size="10" maxlength="20"/></td>
                     <TD><input class="emailAddr" type="text" name="CONTACT_EMAILADDR" size="20" maxlength="80"/></td>
                     <TD style="vertical-align:top;">
                         <table>
                            <tr>
                               <td><input class="phNbrCtryCode" type="text" name="CONTACT_PHONE_NBR_CTRY_CODE" value="<%= phoneCountryCode %>" class="txtfld" size="2" maxlength="4"/></td>
                               <TD><input class="phNbr" type="text" name="CONTACT_PHONE_NBR" class="txtfld" value="" size="15" maxlength="20"/></td>
                            </tr>
                         </table>
                     </td>
                  </TR>

                  <tr class='sectionHeader5'>
                     <td width=2% style="text-align:center;vertical-align:center;">&nbsp;7&nbsp;</td>
                     <TD><input type="text" name="CONTACT_NAME" size="10" maxlength="20"/></td>
                     <TD><input class="emailAddr" type="text" name="CONTACT_EMAILADDR" size="20" maxlength="80"/></td>
                     <TD style="vertical-align:top;">
                         <table>
                            <tr>
                               <td><input class="phNbrCtryCode" type="text" name="CONTACT_PHONE_NBR_CTRY_CODE" value="<%= phoneCountryCode %>" class="txtfld" size="2" maxlength="4"/></td>
                               <TD><input class="phNbr" type="text" name="CONTACT_PHONE_NBR" class="txtfld" value="" size="15" maxlength="20"/></td>
                            </tr>
                         </table>
                     </td>
                  </TR>

                  <tr class='sectionHeader6'>
                     <td width=2% style="text-align:center;vertical-align:center;">&nbsp;8&nbsp;</td>
                     <TD><input type="text" name="CONTACT_NAME" size="10" maxlength="20"/></td>
                     <TD><input class="emailAddr" type="text" name="CONTACT_EMAILADDR" size="20" maxlength="80"/></td>
                     <TD style="vertical-align:top;">
                         <table>
                            <tr>
                               <td><input class="phNbrCtryCode" type="text" name="CONTACT_PHONE_NBR_CTRY_CODE" value="<%= phoneCountryCode %>" class="txtfld" size="2" maxlength="4"/></td>
                               <TD><input class="phNbr" type="text" name="CONTACT_PHONE_NBR" class="txtfld" value="" size="15" maxlength="20"/></td>
                            </tr>
                         </table>
                     </td>
                  </TR>

                  <tr class='sectionHeader5'>
                     <td width=2% style="text-align:center;vertical-align:center;">&nbsp;9&nbsp;</td>
                     <TD><input type="text" name="CONTACT_NAME" size="10" maxlength="20"/></td>
                     <TD><input class="emailAddr" type="text" name="CONTACT_EMAILADDR" size="20" maxlength="80"/></td>
                     <TD style="vertical-align:top;">
                         <table>
                            <tr>
                               <td><input class="phNbrCtryCode" type="text" name="CONTACT_PHONE_NBR_CTRY_CODE" value="<%= phoneCountryCode %>" class="txtfld" size="2" maxlength="4"/></td>
                               <TD><input class="phNbr" type="text" name="CONTACT_PHONE_NBR" class="txtfld" value="" size="15" maxlength="20"/></td>
                            </tr>
                         </table>
                     </td>
                  </TR>

                  <tr class='sectionHeader6'>
                     <td width=2% style="text-align:center;vertical-align:center;">&nbsp;10&nbsp;</td>
                     <TD><input type="text" name="CONTACT_NAME" size="10" maxlength="20"/></td>
                     <TD><input class="emailAddr" type="text" name="CONTACT_EMAILADDR" size="20" maxlength="80"/></td>
                     <TD style="vertical-align:top;">
                         <table>
                            <tr>
                               <td><input class="phNbrCtryCode" type="text" name="CONTACT_PHONE_NBR_CTRY_CODE" value="<%= phoneCountryCode %>" class="txtfld" size="2" maxlength="4"/></td>
                               <TD><input class="phNbr" type="text" name="CONTACT_PHONE_NBR" class="txtfld" value="" size="15" maxlength="20"/></td>
                            </tr>
                         </table>
                     </td>
                  </TR>
               </table>
               <br>
               
               <table width="100%" cellpadding="1" cellspacing="8" border="0">
                   <TR><HR></TR>
                   <tr>
                       <td CLASS="chapterHeader" style="text-align: center;">
                           <input type="image" style="text-align: center;" name="submit" src="../images/submit.gif" onclick="return validate();"/>
                       </td>
                   </tr>
               </table>
            </td>
         </tr>      
      </table>
   
</form>
<jsp:include page="../Footer.jsp?folderLevelDown=1"/>
