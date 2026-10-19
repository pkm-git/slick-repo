<%@ page import="java.util.*" %>
<jsp:include page="../Header.jsp?folderLevelDown=1"/>

<img src="../images/spacer.gif" height="14" style="display:block ">
Congratulations!!&nbsp;You are successfully registered with Rewards2Connect.com!  &nbsp;An email has been sent to you with your registration details.<BR><BR>

<%
   Integer intUserId = (Integer)session.getAttribute("USERID");
Integer intBusinessId = (Integer)session.getAttribute("BUSINESSID");

   String msg = "";
   if (intUserId != null)
{
      msg = "To begin your checkout discount journey:";
}
   else
{
msg = "To begin increasing your revenue:";
}

   List<String> successReferEmailList = (List<String>)session.getAttribute("SUCCESS_EMAIL_REFER_LIST");

   if (successReferEmailList != null && successReferEmailList.size()>0)
   {
      %>
      You successfully referred the following friend(s)/relative(s) of yours today:<br><br>
      <%
      for (int i = 0; i < successReferEmailList.size(); i++)
      {
         %>
         <%= successReferEmailList.get(i) %><br>
         <%
      }
      %>
         <br>
      <%
   }

   List<String> existingUserList = (List<String>)session.getAttribute("EXISTING_USER_EMAIL_REFER_LIST");

   if (existingUserList != null && existingUserList.size()>0)
   {
      %>
      You could not refer the following friend(s)/relative(s) of yours today because they are existing users at Rewards2Connect.com:<br><br>
      <%
      for (int i = 0; i < existingUserList.size(); i++)
      {
         %>
         <%= existingUserList.get(i) %><br>
         <%
      }
      %>
         <br>
      <%
   }

   List<String> alreadyReferredByOthersEmailList = (List<String>)session.getAttribute("ALREADY_REFERRED_EMAIL_LIST");

   if (alreadyReferredByOthersEmailList != null && alreadyReferredByOthersEmailList.size()>0)
   {
      %>
      You could not refer to the following friend(s)/relative(s) of yours today because they have already been referred by others:<br><br>
      <%
      for (int i = 0; i < alreadyReferredByOthersEmailList.size(); i++)
      {
         %>
         <%= alreadyReferredByOthersEmailList.get(i) %><br>
         <%
      }
      %>
         <br>
      <%
   }
%>


&nbsp;<%= msg %><BR>

<BR>
<table width="20%"  border="0"  cellspacing="0" cellpadding="0" align="center">
   <TR><td><img src="../images/spacer.gif" height="8" style="display:block;"></td><td class="JOLButtonInTDWithBorder" style="white-space:nowrap;"><a HREF="ViewProfile.jsp">CLICK HERE</A></TD></tr>
</table>
<jsp:include page="../Footer.jsp?folderLevelDown=1"/>
