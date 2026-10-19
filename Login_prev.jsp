<jsp:include page="../Header.jsp?folderLevelDown=1"/>
<%@ page import="java.sql.*, shared.*, java.util.*" %>
<%
    String strGrpCatId = "";
    int grpCatId = 0;
    String strCatId = "";
    int catId = 0;
    String grpPageHeader = "";
    String grpPageDesc = "";

    String pageHeader = "";
    String pageDesc = "";

    List<String> catPageHeaderList = new ArrayList();
    List<String> catPageDescList = new ArrayList();

    String strErr = request.getParameter("error");
    String errMsg = "";

    if (strErr != null && strErr.equals("notLoggedIn"))
    {
       Statement statement = null;
       ResultSet rs = null;
       
       Connection connection = DBUtils.getConnection();
       statement = connection.createStatement();

       strGrpCatId = request.getParameter("grpCatId");
       
       if (strGrpCatId != null)
       {
          grpCatId = Integer.parseInt(strGrpCatId);
       }
       System.out.println("**** Login.jsp: FROM REQUEST: grpCatId: " + grpCatId);

       strCatId = request.getParameter("catId");      
       
       if (strCatId != null)
       {
          catId = Integer.parseInt(strCatId);
       }
       System.out.println("**** Login.jsp: FROM REQUEST: catId: " + catId);

       if (grpCatId != 0 && catId == 0)
       {
          String sqlSelectGrpCat = "select gc.group_page_header, gc.group_page_desc, c.page_header, c.page_desc from group_category gc, category c where c.group_cat_id = gc.group_cat_id and c.group_cat_id = " + grpCatId;

          System.out.println(" **** sqlSelectGrpCat: " + sqlSelectGrpCat);

          rs = statement.executeQuery(sqlSelectGrpCat);

          System.out.println(" **** sqlSelectGrpCat OVER ");

          int cnt = 0;
                             
          while (rs.next())
          {
             cnt++;
             System.out.println(" *** cnt: " + cnt);

             if (cnt == 1)
             {
                grpPageHeader = rs.getString("group_page_header");
                grpPageDesc = rs.getString("group_page_desc");
             }

             pageHeader = rs.getString("page_header");
             pageDesc = rs.getString("page_desc");

             System.out.println(" **** grpPageHeader: " + grpPageHeader + ", pageHeader: " + pageHeader);

             catPageHeaderList.add(pageHeader);
             catPageDescList.add(pageDesc);
          } // while (rs.next())..
       %>
          <table width="70%"  border="0"  cellspacing="0" cellpadding="0" align="center">
             <tr>
                  <td width="2%" valign="top">&nbsp;</td>
                  <td width="95%" valign="top">
                      <table width="90%"  border="0"  cellspacing="0" cellpadding="0" align="center">
                         <TR><TD><img alt="" src="../images/spacer.gif" height="10" style="display:block "></TD></TR>
                         <tr>
                            <TD width=25% style="white-space:nowrap;">
                               <table><tr class="chapterHeader"><td>GROUP CATEGORY:</td></tr></table>
                            </td>
                            <TD>
                                <table><tr class="sectionHeader2"><td><%= grpPageHeader %></td></tr></table>
                            </td>
                         </TR> 
                         <TR><TD colspan=2><img alt="" src="../images/spacer.gif" height="14" style="display:block "></TD></TR>
                         <TR>
                             <TD colspan=2><img alt="" src="../images/spacer.gif" height="1" style="display:block "><%= grpPageDesc %></td>
                         </tr>
                      </table>
                  </td>
                  <td width="1%" valign="top"></td>
                  <td valign="top"></td>
             </tr>
             <tr><td colspan=4><img alt="" src="../images/spacer.gif" height="1" style="display:block"></td></tr>
          </table>
       <%
          for (int i=0; i < catPageHeaderList.size(); i++)
          {
             pageHeader = catPageHeaderList.get(i);
             pageDesc = catPageDescList.get(i);
       %>
                <table width="90%"  border="0"  cellspacing="0" cellpadding="0" align="center">
                   <tr>
                        <td width="3%" valign="top">&nbsp;</td>
                        <td width="85%" valign="top">
                            <table width="90%"  border="0"  cellspacing="0" cellpadding="0" align="center">
                               <TR><TD><img alt="" src="../images/spacer.gif" height="10" style="display:block "></TD></TR>
                               <tr>
                                  <TD width=20% style="white-space:nowrap;">
                                     <table><tr class="chapterHeader"><td>SUB-CATEGORY <%= (i+1) %>:</td></tr></table>
                                  </td>
                                  <TD>
                                      <table><tr class="sectionHeader2"><td><%= pageHeader %></td></tr></table>
                                  </td>
                               </TR> 
                               <TR><TD colspan=2><img alt="" src="../images/spacer.gif" height="14" style="display:block "></TD></TR>
                               <TR>
                                   <TD colspan=2><img alt="" src="../images/spacer.gif" height="1" style="display:block "><%= pageDesc %></td>
                               </tr>
                            </table>
                        </td>
                        <td width="1%" valign="top"></td>
                   </tr>
                   <tr><td colspan=4><img alt="" src="../images/spacer.gif" height="1" style="display:block"></td></tr>
                </table>
       <%
          } // for (int i=0; i < catPageHeaderList.size(); i++)..
       }
       else if (catId != 0)
       {
          System.out.println(" **** catId is NOT zero: " + catId);

          List adList = new ArrayList();
          Ad ad;

          String sqlSelectCat = "select gc.group_page_header, gc.group_page_desc, c.page_header, c.page_desc from group_category gc, category c where c.group_cat_id = gc.group_cat_id and c.cat_id = " + catId;
          rs = statement.executeQuery(sqlSelectCat);
          while (rs.next())
          {
             grpPageHeader = rs.getString("group_page_header");
             grpPageDesc = rs.getString("group_page_desc");
             pageHeader = rs.getString("page_header");
             pageDesc = rs.getString("page_desc");
             break;
          }
       %>
       <table width="80%"  border="0"  cellspacing="0" cellpadding="0" align="center">
          <tr>
               <td width="2%" valign="top">&nbsp;</td>
               <td width="95%" valign="top">
                   <table width="70%"  border="0"  cellspacing="0" cellpadding="0" align="center">
                      <TR><TD colspan=7><img alt="" src="../images/spacer.gif" height="14" style="display:block "></TD></TR>
                      <tr>
                          <TD width=25%>
                             <table><tr class="chapterHeader"><td style="white-space:nowrap;">GROUP CATEGORY:</td></tr></table>
                          </td>
                          <TD width=2%>&nbsp;</td>
                          <TD>
                              <table><tr class="chapterHeader"><td style="white-space:nowrap;"><%= grpPageHeader %></td></tr></table>
                          </td>
                          <TD><img src="../images/arrow.png"/></TD>
                          <TD width=25%>
                             <table><tr class="sectionHeader2"><td style="white-space:nowrap;">SUB-CATEGORY:</td></tr></table>
                          </td>
                          <TD width=2%>&nbsp;</td>
                          <TD>
                              <table><tr class="sectionHeader2"><td style="white-space:nowrap;"><%= pageHeader %></td></tr></table>
                          </td>
                      </TR> 
                      <TR><TD colspan=7><img alt="" src="../images/spacer.gif" height="14" style="display:block "></TD></TR>
                      <TR><TD colspan=7><img alt="" src="../images/spacer.gif" height="4" style="display:block "><%= pageDesc %></td></tr>
                   </table>
               </td>
               <td width="1%" valign="top"></td>
               <td valign="top"></td>
          </tr>
          <tr><td colspan=4><img alt="" src="../images/spacer.gif" height="14" style="display:block"></td></tr>
       </table>
    <%
       } // if (grpCatId != 0 && catId == 0)..
    }
%>
<HTML>
<HEAD>
<SCRIPT LANGUAGE="JAVASCRIPT">
function validate()
{
   if (document.uloginform.USERNAME.value == "")
   {
       alert("Username cannot be empty.");
       return false;
   }
   else if (document.uloginform.PASSWORD.value == "")
   {
       alert("Password cannot be empty.");
       return false;
   }  
   return true;
}
</SCRIPT>
</HEAD>

<form name="loginform" action="ProcessLogin.jsp" method="post">
   <BR>
   <table width=60%>
<%
   if (strErr != null && strErr.equals("notLoggedIn"))
   {
%>
      <tr class="sectionHeader"><td>Please login before placing an ad or posting a message.</td></tr>
   </table>
   <br>
   <table width=60%>
      <tr class="chapterHeader">
<%
   }
   else if (strErr != null && strErr.equals("errorEmailNotInSystem"))
   {
      errMsg = "The email address entered is not in the system.  Please click on Register link to register as a new user.";
      %>
         <tr>
             <td class="redM1"><%= errMsg %><img src="../images/spacer.gif" height="8" style="display:block"></td>
         <tr>
      </table>
      <br>
      <table width=60%>
         <tr class="chapterHeader">
      <%
   } // if (strErr != null &&..
   else
   {
%>
      <tr class="chapterHeader">
<%
   }
%>
         <td valign="top">LOGIN:</td>
      </tr>
      <tr><td><img src="../images/spacer.gif" height="10" style="display:block">Username:&nbsp;<input name="USERNAME" type="text" required="true"><img alt=""  src="../images/spacer.gif" height="10" style="display:block "></td></tr>
      <tr><td>Password:&nbsp;&nbsp;<input name="PASSWORD" type="password" onClick="this.value=''" required="true"><img alt=""  src="../images/spacer.gif" height="10" style="display:block "></td></tr>
      <tr><td style="text-align: center;">
         <%-- %><INPUT TYPE="SUBMIT" VALUE="OK" style="width:30px; height:16px; background:url(<%= rootLevelPrepend %>images/button_ok.gif) no-repeat top right;  border:0px none; cursor:hand; cursor:pointer;"> --%>
          <input type="image" name="submit" src="../images/submit.gif" onclick="if validate() {document.forms.loginform.submit();}"/>
      </td></tr>
   </table>
</form>

<br>
<table>
   <tr><td CLASS="JOLButtonInTDWithBorder">Not signed up?&nbsp;&nbsp;<A HREF="Register.jsp">REGISTER HERE</a><img src="../images/spacer.gif" height="10" style="display:block"></td></tr>
   <tr><td CLASS="JOLButtonInTDWithBorder">Forgot Password?&nbsp;&nbsp;<A HREF="ForgotPassword.jsp">CLICK HERE</a></td></tr>
</table>

<jsp:include page="../Footer.jsp?folderLevelDown=1"/>
