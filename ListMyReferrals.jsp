<jsp:include page="../Header.jsp?folderLevelDown=1"/>
<%@ page import="java.sql.*, shared.*, java.util.*" %>
<%
   Statement statement = null;
   Statement statement2 = null;
   ResultSet rs = null;
   ResultSet rs2 = null;
   
   Connection connection = DBUtils.getConnection();
   statement = connection.createStatement();

   System.out.println("*************** in List My Referrals jsp ");
   
   int userId = 0;
   int userLoginId = 0;

   Integer intUserId = (Integer)session.getAttribute("USERID");
   Integer intUserLoginId = (Integer)session.getAttribute("USERLOGINID");  

   List refUserList = new ArrayList();
   ReferUser refUser;

   if (intUserId != null)
   {
      System.out.println("*********** user id in session = " + intUserId);
      userId = intUserId.intValue();

      if (intUserLoginId != null) userLoginId = intUserLoginId.intValue();

      String sqlSelectReferrals = "select * from refer_user where user_id = " + userId + " order by date_referred desc";

      System.out.println(" **** sqlSelectReferrals: " + sqlSelectReferrals);

      rs = statement.executeQuery(sqlSelectReferrals);
      boolean found = false;

      while (rs.next())
      {
         refUser = new ReferUser();
         refUser.referUserId = rs.getInt("refer_user_id");
         refUser.userId = rs.getInt("user_id");
         refUser.referName = rs.getString("name");
         refUser.referEmailAddr = rs.getString("referred_email_addr");
         if (refUser.referEmailAddr == null) refUser.referEmailAddr = "";

         refUser.referPhoneNbr = rs.getString("referred_phone_nbr");
         if (refUser.referPhoneNbr == null) refUser.referPhoneNbr = "";

         refUser.dateReferred = DateUtils.format(rs.getString("date_referred"), true);

         refUser.hasReferredSignedUp = rs.getInt("has_referred_signed_up");
         refUser.dateReferredSignedUp = DateUtils.format(rs.getString("date_referred_signed_up"), true);
         
         refUserList.add(refUser);
      }

      session.setAttribute("MYREFUSERLIST", refUserList);
   }
%>
   <br>

   <table width="60%"  border="0"  cellspacing="6" cellpadding="6" align="center">
      <TR CLASS="JOLButtonInTDWithBorder">
         <td width="2%" valign="top"><img src="../images/spacer.gif" height="5" style="display:block"></td>
         <TD width="50%" style="white-space:nowrap;" CLASS="chapterHeader">&nbsp;My Referrals</TD>

         <td width="6%" valign="top">&nbsp;</td>

         <TD style="white-space:nowrap;"><img src="../images/spacer.gif" height="6" style="display:block"><a HREF="ReferMore.jsp">Refer More</A></TD>

         <td width="1%" valign="top">&nbsp;</td>
         <TD><img src="../images/spacer.gif" height="6" style="display:block"><a HREF="ViewProfile.jsp">View Profile</A></TD>
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
                           <td>&nbsp;Referred Name</td>
                           <td>Date Referred</td>
                           <td>Referred Email</td>
                           <td>Referred Phone No.</td>
                           <td>Signed Up?</td>
                           <td>Sign Up Date</td>
                        </tr>
                        <%
                           String rowClass = "sectionHeader6";
                           String hasSignedUp = "No";

                           if (refUserList.size() == 0)
                           {
                        %>
                             <tr class="<%= rowClass %>"><td colspan=5>&nbsp;No referrals yet.</td></tr>
                        <%
                           }
                           else
                           {
                              for (int i=0; i < refUserList.size(); i++)
                              {
                                 refUser = (ReferUser)refUserList.get(i);
                           %>
                                 <tr class="<%= rowClass %>">
                                    <TD style="white-space:nowrap;">&nbsp;<%= refUser.referName %></td>
                                    <TD style="white-space:nowrap;">&nbsp;<%= refUser.dateReferred %></td>
                                    <TD style="white-space:nowrap;">&nbsp;<%= refUser.referEmailAddr %></td>
                                    <TD style="white-space:nowrap;">&nbsp;<%= refUser.referPhoneNbr %></td>
                                    <%
                                       if (refUser.hasReferredSignedUp == 1)
                                       {
                                          hasSignedUp = "Yes";
                                       }
                                    %>
                                    <TD style="text-align: center;"><%= hasSignedUp %></td>
                                    <TD style="white-space:nowrap;"><%= refUser.dateReferredSignedUp %></td>
                                 </tr>
                           <%
                                 if (rowClass.equals("sectionHeader5"))
                                     rowClass = "sectionHeader6";
                                 else rowClass = "sectionHeader5";
                              } //for (int i=0; i < refUserList.size(); i++)..
                           }
                        %>

                     </table>
                  </td>
               </tr>
            </table>
        </td>
     </tr>
  </table>
<jsp:include page="../Footer.jsp?folderLevelDown=1"/>
