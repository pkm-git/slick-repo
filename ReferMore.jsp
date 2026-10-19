<%@ page import="java.sql.*, java.util.*, shared.*" %>
<%
    String phoneCountryCode = (String)session.getAttribute("PH_CTRY_CODE");
    if (phoneCountryCode == null) phoneCountryCode = "+1";

    // VonageSendSms.sendSms("+12489461570");
%>
<html>
<head>
<title>Rewards2Connect.com - Refer More People</title>
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
      alert("You must enter at least one referral email address OR phone number with a country code starting with + sign.");
      return false;
   }
       
   return true;
}
</script>
</head>

<jsp:include page="../Header.jsp?folderLevelDown=1"/>

    <table WIDTH=100%>
       <tr class="sectionHeader"><td>&nbsp;Refer Others to Rewards2Connect.com</td></TR>
    </TABLE>
    <br>
   
    Please enter more referrals of your friends or relatives here.. <br><br>

    <form onSubmit="onSubmitAction()" name="mainForm" method="POST" action="ProcessReferMore.jsp">
   
    <TABLE border=0 WIDTH=100%>
    <tr><td>
   
    <table width="80%" cellpadding="1" cellspacing="1" border="0">
       <tr>
          <TD style="white-space:nowrap;">Refer to: Name 1<img src="../images/spacer.gif" height="8" style="display:block"></td>
          <TD><input type="text" name="REF_NAME" size="10" maxlength="20"/></td>

          <TD style="white-space:nowrap;">&nbsp;E-mail:&nbsp;</td>
          <TD><input class="emailAddr" type="text" name="REF_EMAILADDR" size="20" maxlength="80"/></td>

          <TD width=20% style="white-space:nowrap;">&nbsp;OR: Phone Ctry Code&nbsp;</td>
          <TD>&nbsp;<input class="phNbrCtryCode" id="REF_PH_NBR_CTRY_CODE" type="text" name="REF_PHONE_NBR_CTRY_CODE" value="<%= phoneCountryCode %>" class="txtfld" size="2" maxlength="4"/></td>
          <TD>&nbsp;Number&nbsp;</td>
          <TD><input class="phNbr" type="text" name="REF_PHONE_NBR" class="txtfld" value="" size="15" maxlength="20"/></td>
       </TR>
       <tr>
          <TD style="white-space:nowrap;">Refer to: Name 2<img src="../images/spacer.gif" height="8" style="display:block"></td>
          <TD><input type="text" name="REF_NAME" size="10" maxlength="20"/></td>

          <TD style="white-space:nowrap;">&nbsp;E-mail:&nbsp;</td>
          <TD><input class="emailAddr" type="text" name="REF_EMAILADDR" size="20" maxlength="80"/></td>

          <TD width=20% style="white-space:nowrap;">&nbsp;OR: Phone Ctry Code&nbsp;</td>
          <TD>&nbsp;<input class="phNbrCtryCode" id="REF_PH_NBR_CTRY_CODE" type="text" name="REF_PHONE_NBR_CTRY_CODE" value="<%= phoneCountryCode %>" class="txtfld" size="2" maxlength="4"/></td>
          <TD>&nbsp;Number&nbsp;</td>
          <TD><input class="phNbr" type="text" name="REF_PHONE_NBR" class="txtfld" value="" size="15" maxlength="20"/></td>
       </TR>
       <tr>
          <TD style="white-space:nowrap;">Refer to: Name 3<img src="../images/spacer.gif" height="8" style="display:block"></td>
          <TD><input type="text" name="REF_NAME" size="10" maxlength="20"/></td>

          <TD style="white-space:nowrap;">&nbsp;E-mail:&nbsp;</td>
          <TD><input class="emailAddr" type="text" name="REF_EMAILADDR" size="20" maxlength="80"/></td>

          <TD width=20% style="white-space:nowrap;">&nbsp;OR: Phone Ctry Code&nbsp;</td>
          <TD>&nbsp;<input class="phNbrCtryCode" id="REF_PH_NBR_CTRY_CODE" type="text" name="REF_PHONE_NBR_CTRY_CODE" value="<%= phoneCountryCode %>" class="txtfld" size="2" maxlength="4"/></td>
          <TD>&nbsp;Number&nbsp;</td>
          <TD><input class="phNbr" type="text" name="REF_PHONE_NBR" class="txtfld" value="" size="15" maxlength="20"/></td>
       </TR>
       <tr>
          <TD style="white-space:nowrap;">Refer to: Name 4<img src="../images/spacer.gif" height="8" style="display:block"></td>
          <TD><input type="text" name="REF_NAME" size="10" maxlength="20"/></td>

          <TD style="white-space:nowrap;">&nbsp;E-mail:&nbsp;</td>
          <TD><input class="emailAddr" type="text" name="REF_EMAILADDR" size="20" maxlength="80"/></td>

          <TD width=20% style="white-space:nowrap;">&nbsp;OR: Phone Ctry Code&nbsp;</td>
          <TD>&nbsp;<input class="phNbrCtryCode" id="REF_PH_NBR_CTRY_CODE" type="text" name="REF_PHONE_NBR_CTRY_CODE" value="<%= phoneCountryCode %>" class="txtfld" size="2" maxlength="4"/></td>
          <TD>&nbsp;Number&nbsp;</td>
          <TD><input class="phNbr" type="text" name="REF_PHONE_NBR" class="txtfld" value="" size="15" maxlength="20"/></td>
       </TR>
       <tr>
          <TD style="white-space:nowrap;">Refer to: Name 5<img src="../images/spacer.gif" height="8" style="display:block"></td>
          <TD><input type="text" name="REF_NAME" size="10" maxlength="20"/></td>

          <TD style="white-space:nowrap;">&nbsp;E-mail:&nbsp;</td>
          <TD><input class="emailAddr" type="text" name="REF_EMAILADDR" size="20" maxlength="80"/></td>

          <TD width=20% style="white-space:nowrap;">&nbsp;OR: Phone Ctry Code&nbsp;</td>
          <TD>&nbsp;<input class="phNbrCtryCode" id="REF_PH_NBR_CTRY_CODE" type="text" name="REF_PHONE_NBR_CTRY_CODE" value="<%= phoneCountryCode %>" class="txtfld" size="2" maxlength="4"/></td>
          <TD>&nbsp;Number&nbsp;</td>
          <TD><input class="phNbr" type="text" name="REF_PHONE_NBR" class="txtfld" value="" size="15" maxlength="20"/></td>
       </TR>
       <tr>
          <TD style="white-space:nowrap;">Refer to: Name 6<img src="../images/spacer.gif" height="8" style="display:block"></td>
          <TD><input type="text" name="REF_NAME" size="10" maxlength="20"/></td>

          <TD style="white-space:nowrap;">&nbsp;E-mail:&nbsp;</td>
          <TD><input class="emailAddr" type="text" name="REF_EMAILADDR" size="20" maxlength="80"/></td>

          <TD width=20% style="white-space:nowrap;">&nbsp;OR: Phone Ctry Code&nbsp;</td>
          <TD>&nbsp;<input class="phNbrCtryCode" id="REF_PH_NBR_CTRY_CODE" type="text" name="REF_PHONE_NBR_CTRY_CODE" value="<%= phoneCountryCode %>" class="txtfld" size="2" maxlength="4"/></td>
          <TD>&nbsp;Number&nbsp;</td>
          <TD><input class="phNbr" type="text" name="REF_PHONE_NBR" class="txtfld" value="" size="15" maxlength="20"/></td>
       </TR>
       <tr>
          <TD style="white-space:nowrap;">Refer to: Name 7<img src="../images/spacer.gif" height="8" style="display:block"></td>
          <TD><input type="text" name="REF_NAME" size="10" maxlength="20"/></td>

          <TD style="white-space:nowrap;">&nbsp;E-mail:&nbsp;</td>
          <TD><input class="emailAddr" type="text" name="REF_EMAILADDR" size="20" maxlength="80"/></td>

          <TD width=20% style="white-space:nowrap;">&nbsp;OR: Phone Ctry Code&nbsp;</td>
          <TD>&nbsp;<input class="phNbrCtryCode" id="REF_PH_NBR_CTRY_CODE" type="text" name="REF_PHONE_NBR_CTRY_CODE" value="<%= phoneCountryCode %>" class="txtfld" size="2" maxlength="4"/></td>
          <TD>&nbsp;Number&nbsp;</td>
          <TD><input class="phNbr" type="text" name="REF_PHONE_NBR" class="txtfld" value="" size="15" maxlength="20"/></td>
       </TR>
       <tr>
          <TD style="white-space:nowrap;">Refer to: Name 8<img src="../images/spacer.gif" height="8" style="display:block"></td>
          <TD><input type="text" name="REF_NAME" size="10" maxlength="20"/></td>

          <TD style="white-space:nowrap;">&nbsp;E-mail:&nbsp;</td>
          <TD><input class="emailAddr" type="text" name="REF_EMAILADDR" size="20" maxlength="80"/></td>

          <TD width=20% style="white-space:nowrap;">&nbsp;OR: Phone Ctry Code&nbsp;</td>
          <TD>&nbsp;<input class="phNbrCtryCode" id="REF_PH_NBR_CTRY_CODE" type="text" name="REF_PHONE_NBR_CTRY_CODE" value="<%= phoneCountryCode %>" class="txtfld" size="2" maxlength="4"/></td>
          <TD>&nbsp;Number&nbsp;</td>
          <TD><input class="phNbr" type="text" name="REF_PHONE_NBR" class="txtfld" value="" size="15" maxlength="20"/></td>
       </TR>
       <tr>
          <TD style="white-space:nowrap;">Refer to: Name 9<img src="../images/spacer.gif" height="8" style="display:block"></td>
          <TD><input type="text" name="REF_NAME" size="10" maxlength="20"/></td>

          <TD style="white-space:nowrap;">&nbsp;E-mail:&nbsp;</td>
          <TD><input class="emailAddr" type="text" name="REF_EMAILADDR" size="20" maxlength="80"/></td>

          <TD width=20% style="white-space:nowrap;">&nbsp;OR: Phone Ctry Code&nbsp;</td>
          <TD>&nbsp;<input class="phNbrCtryCode" id="REF_PH_NBR_CTRY_CODE" type="text" name="REF_PHONE_NBR_CTRY_CODE" value="<%= phoneCountryCode %>" class="txtfld" size="2" maxlength="4"/></td>
          <TD>&nbsp;Number&nbsp;</td>
          <TD><input class="phNbr" type="text" name="REF_PHONE_NBR" class="txtfld" value="" size="15" maxlength="20"/></td>
       </TR>
       <tr>
          <TD style="white-space:nowrap;">Refer to: Name 10<img src="../images/spacer.gif" height="8" style="display:block"></td>
          <TD><input type="text" name="REF_NAME" size="10" maxlength="20"/></td>

          <TD style="white-space:nowrap;">&nbsp;E-mail:&nbsp;</td>
          <TD><input class="emailAddr" type="text" name="REF_EMAILADDR" size="20" maxlength="80"/></td>

          <TD width=20% style="white-space:nowrap;">&nbsp;OR: Phone Ctry Code&nbsp;</td>
          <TD>&nbsp;<input class="phNbrCtryCode" id="REF_PH_NBR_CTRY_CODE" type="text" name="REF_PHONE_NBR_CTRY_CODE" value="<%= phoneCountryCode %>" class="txtfld" size="2" maxlength="4"/></td>
          <TD>&nbsp;Number&nbsp;</td>
          <TD><input class="phNbr" type="text" name="REF_PHONE_NBR" class="txtfld" value="" size="15" maxlength="20"/></td>
       </TR>
    </table>
   
    <table width="80%" cellpadding="1" cellspacing="8" border="0">
        <TR><HR></TR>
        <tr>
            <td CLASS="chapterHeader" style="text-align: center;">
                <input type="image" style="text-align: center;" name="submit" src="../images/submit.gif" onclick="return validate();"/>
            </td>
        </tr>
    </table>
   
    </td></tr>
    </table>
   
</form>
<jsp:include page="../Footer.jsp?folderLevelDown=1"/>
