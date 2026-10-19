<%@ page import="java.sql.*, java.util.*, shared.*" %>
<html>
<head>
<title>Rewards2Connect.com - Refer More People</title>
<!--
<link rel="stylesheet" type="text/css" href="../styles/styles1.css" />
<link rel="stylesheet" type="text/css" href="../styles/styles.css" />
-->
<SCRIPT LANGUAGE="JAVASCRIPT">
function validate()
{
   emailAddrs = document.getElementsByClassName("emailAddr");

   var found = false;

   for (i = 0; i < emailAddrs.length; i++)
   {
       if (emailAddrs[i].value != "")
       {
          found = true;
          break;
       } // if (emailAddrs[i].value != "")..
   } // for (i = 0; i < emailAddrs.length; i++)..
   
   if (!found)
   {
      alert("You must enter at least one referral email address.");
      return false;
   }
        
   return true;
}
</script>
</head>

<jsp:include page="../Header.jsp?folderLevelDown=1"/>

    <table WIDTH=100%>
       <tr class="sectionHeader"><td>Refers Others to Rewards2Connect.com</td></TR>
    </TABLE>
    <br>
    
    Please enter more referrals of your friends or relatives here.. <br><br>

    <form onSubmit="onSubmitAction()" name="mainForm" method="POST" action="ProcessReferMore.jsp">
    
    <TABLE border=0 WIDTH=100%> 
    <tr><td>
    
    <table width="80%" cellpadding="6" cellspacing="8" border="0">
       <tr>
          <TD style="white-space:nowrap;">Refer to E-mail 1&nbsp;<img src="../images/spacer.gif" height="8" style="display:block"></td>
          <td>
              <input class="emailAddr" type="text" name="REF_EMAILADDR" size="20" maxlength="80" />
          </td>
          <TD style="white-space:nowrap;">&nbsp;&nbsp;Refer to E-mail 2&nbsp;</td>
          <td colspan=2>
              <input class="emailAddr" type="text" name="REF_EMAILADDR" size="20" maxlength="80" />
          </td>
       </TR>
       <tr>
          <TD style="white-space:nowrap;">Refer to E-mail 3&nbsp;<img src="../images/spacer.gif" height="8" style="display:block"></td>
          <td>
              <input class="emailAddr" type="text" name="REF_EMAILADDR" size="20" maxlength="80" />
          </td>
          <TD style="white-space:nowrap;">&nbsp;&nbsp;Refer to E-mail 4&nbsp;</td>
          <td colspan=2>
              <input class="emailAddr" type="text" name="REF_EMAILADDR" size="20" maxlength="80" />
          </td>
       </TR>
       <tr>
          <TD style="white-space:nowrap;">Refer to E-mail 5&nbsp;<img src="../images/spacer.gif" height="8" style="display:block"></td>
          <td>
              <input class="emailAddr" type="text" name="REF_EMAILADDR" size="20" maxlength="80" />
          </td>
          <TD style="white-space:nowrap;">&nbsp;&nbsp;Refer to E-mail 6&nbsp;</td>
          <td colspan=2>
              <input class="emailAddr" type="text" name="REF_EMAILADDR" size="20" maxlength="80" />
          </td>
       </TR>
       <tr>
          <TD style="white-space:nowrap;">Refer to E-mail 7&nbsp;<img src="../images/spacer.gif" height="8" style="display:block"></td>
          <td>
              <input class="emailAddr" type="text" name="REF_EMAILADDR" size="20" maxlength="80" />
          </td>
          <TD style="white-space:nowrap;">&nbsp;&nbsp;Refer to E-mail 8&nbsp;</td>
          <td colspan=2>
              <input class="emailAddr" type="text" name="REF_EMAILADDR" size="20" maxlength="80" />
          </td>
       </TR>
       <tr>
          <TD style="white-space:nowrap;">Refer to E-mail 9&nbsp;<img src="../images/spacer.gif" height="8" style="display:block"></td>
          <td>
              <input class="emailAddr" type="text" name="REF_EMAILADDR" size="20" maxlength="80" />
          </td>
          <TD style="white-space:nowrap;">&nbsp;&nbsp;Refer to E-mail 10&nbsp;</td>
          <td colspan=2>
              <input class="emailAddr" type="text" name="REF_EMAILADDR" size="20" maxlength="80" />
          </td>
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
