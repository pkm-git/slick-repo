<%@ page import="java.util.*" %>
<jsp:include page="../Header.jsp?folderLevelDown=1"/>

<img src="../images/spacer.gif" height="14" style="display:block ">
Awesome.. thanks for adding your contacts at Rewards2Connect.com!!<BR><BR>

<%
   List<String> successContactEmailList = (List<String>)session.getAttribute("SUCCESS_EMAIL_CONTACT_LIST");

   if (successContactEmailList != null && successContactEmailList.size()>0)
   {
      %>
      You successfully added the following friend(s)/relative(s) of yours today:<br><br>
      <%
      for (int i = 0; i < successContactEmailList.size(); i++)
      {
         %>
         <%= successContactEmailList.get(i) %><br>
         <%
      }
      %>
         <br>
      <%
   }

   List<String> existingUserList = (List<String>)session.getAttribute("EXISTING_USER_EMAIL_CONTACT_LIST");

   if (existingUserList != null && existingUserList.size()>0)
   {
      %>
      You could not add the following friend(s)/relative(s) of yours today because they are existing users at Rewards2Connect.com:<br><br>
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
%>

&nbsp;To view a full list of contacts added till date:<BR>

<BR>
<table width="20%"  border="0"  cellspacing="0" cellpadding="0" align="center">
   <TR><td><img src="../images/spacer.gif" height="8" style="display:block "></td><td class="JOLButtonInTDWithBorder"><a HREF="ListMyContacts.jsp">CLICK HERE</A></TD></tr>
</table>
<jsp:include page="../Footer.jsp?folderLevelDown=1"/>


