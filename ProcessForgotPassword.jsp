<!-- Begin: ProcessForgotPassword.jsp -->
<%@ page import="java.sql.*, java.util.*, shared.*" %>
<%
   Statement statement = null;
   ResultSet rs = null;
 
   Connection connection = DBUtils.getConnection();
   
   statement = connection.createStatement();
     
   String emailAddr = request.getParameter("EMAILADDR");

   if (emailAddr != null && emailAddr != "")
   {
      boolean found = false;

      rs = statement.executeQuery("SELECT * FROM user u, contact c where u.user_id = c.user_id and c.email_addr = '" + emailAddr + "'");

      String username = "";
      while (rs.next())
      {
         username = rs.getString("username");
         found = true;
         break;
      }

      if (found)
      {
         session.setAttribute("USERNAME", username);

         String verCode = CodeGenerator.generateRandomSixDigitCode();
         session.setAttribute("VERCODE", verCode);

         String verCodeMsg = "Your username at Rewards2Connect.com is:\n\n";
         verCodeMsg += username + "\n\n";
         verCodeMsg += "Here is the verification code that you need to enter on Rewards2Connect.com to reset your password:\n\n";
         verCodeMsg += verCode;

         // response.sendRedirect("Register.jsp?error=errorEmailAlreadyRegistered");
         // EmailSender.sendEmail(emailAddr, "Verification Code at Rewards2Connect.com", verCodeMsg);

         response.sendRedirect("ForgotPassword.jsp?state=inputVerifyCode");
      }
      else
      {  
         response.sendRedirect("Login.jsp?state=errorEmailNotInSystem");
      } // if (found)..
   }
   else
   {
      String verCode = (String) session.getAttribute("VERCODE");

      String verifyCodeEntered = request.getParameter("VERCODE");

      if (verCode != null && verCode.equals(verifyCodeEntered))
      {
         response.sendRedirect("ForgotPassword.jsp?state=verifySuccess");
      }
   }

%>
<!-- End: ProcessForgotPassword.jsp -->
