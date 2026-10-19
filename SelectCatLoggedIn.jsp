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

   String strGrpCatId = request.getParameter("grpCatId");

   int grpCatId = 0;
   if (strGrpCatId != null)
   {
      grpCatId = Integer.parseInt(strGrpCatId);
   }
   System.out.println("**** PlaceMsgLoggedIn.jsp: FROM REQUEST: grpCatId: " + grpCatId);

   String strCatId = request.getParameter("catId");      

   int catId = 0;
   if (strCatId != null)
   {
      catId = Integer.parseInt(strCatId);
   }
   System.out.println("**** PlaceMsgLoggedIn.jsp: FROM REQUEST: catId: " + catId);

   int userId = 0;
   int userLoginId = 0;

   Integer intUserId = (Integer)session.getAttribute("USERID");

   if (intUserId != null) userId = intUserId.intValue();

   System.out.println(" **** in Place Ad Logged In jsp, userId: " + userId);

   List<GroupCategory> grpCatList = null;
   List<Category> catList = null;

   String grpPageHeader = "";
   String grpPageDesc = "";

   String pageHeader = "";
   String pageDesc = "";

   List<String> catPageHeaderList = new ArrayList();
   List<String> catPageDescList = new ArrayList();

   if (userId != 0)
   {
      Category cat = null;
      GroupCategory grpCat = null;
      List catAttrList = new ArrayList();
      CatAttr catAttr;
      CatAttrDetail catAttrDetail;

      String catLabel = "";
      String catOptionsStr = "";
      String grpCatOptionsStr = "";

      if (grpCatId == 0 && catId == 0)
      {
         grpCatList = (List<GroupCategory>)session.getAttribute("GROUPCATLIST");

         if (grpCatList == null)
         {
             System.out.println(" **** grpCatList is null: ");

             grpCatList = DBUtils.getGroupCatList();
         }
         
         System.out.println(" **** grpCatList is NOT null: size: " + grpCatList.size());

         //session.setAttribute("GROUPCATLIST", grpCatList);

         for (int i=0; i < grpCatList.size(); i++)
         {
            grpCat = (GroupCategory)grpCatList.get(i);
            if (i == 0)
            {
               grpCatOptionsStr += "<option selected=\"1\" value=\"" + grpCat.grpCatId + "\">" + grpCat.grpCatName + "</option>\n";
            }
            else
            {
               grpCatOptionsStr += "<option value=\"" + grpCat.grpCatId + "\">" + grpCat.grpCatName + "</option>\n";
            }      
         }    

         System.out.println(" **** grpCatOptionsStr: " + grpCatOptionsStr);
      }
      else if (grpCatId != 0 && catId == 0)
      {
         System.out.println(" **** grpCatId IS NON zero: " + grpCatId);

         catList = DBUtils.getCatListbyGroupCatId(grpCatId);

         if (catList != null)
         {
            System.out.println(" **** catList is NOT null, len = " + catList.size());
                               
            for (int i=0; i < catList.size(); i++)
            {
               cat = (Category)catList.get(i);

               System.out.println(" **** i = " + i + ", cat.catLabel: " + cat.catLabel);
                                 
               if (i == 0)
               {
                  grpPageHeader = cat.grpPageHeader;
                  grpPageDesc = cat.grpPageDesc;

                  catOptionsStr += "<option selected=\"1\" value=\"" + cat.catId + "\">" + cat.catLabel + "</option>\n";
                  System.out.println(" **** grpPageHeader: " + grpPageHeader + ", grpPageDesc: " + grpPageDesc);
               }
               else
               {
                  catOptionsStr += "<option value=\"" + cat.catId + "\">" + cat.catLabel + "</option>\n";
               }

               catPageHeaderList.add(cat.pageHeader);
               catPageDescList.add(cat.pageDesc);
            }
            System.out.println(" **** catOptionsStr: " + catOptionsStr);
         }
         else
         {
            System.out.println(" **** catList IS null");
         }
      } // if (grpCatId == 0)..

      else if (catId != 0)
      {
         System.out.println(" **** catId is NOT zero: " + catId);

         List adList = new ArrayList();
         Ad ad;
         int grpCatTypeId = 0, catIdToUse = 0;

         String sqlSelectCat = "select c.group_cat_id, gc.group_cat_type_id, gc.group_page_header, gc.group_page_desc, c.page_header, c.page_desc from group_category gc, category c where c.group_cat_id = gc.group_cat_id and c.cat_id = " + catId;
         rs = statement.executeQuery(sqlSelectCat);
         while (rs.next())
         {
            grpCatId = rs.getInt("group_cat_id");
            grpCatTypeId = rs.getInt("group_cat_type_id");        
            grpPageHeader = rs.getString("group_page_header");
            grpPageDesc = rs.getString("group_page_desc");
            pageHeader = rs.getString("page_header");
            pageDesc = rs.getString("page_desc");
            break;
         }
         if (grpCatId != 800 && grpCatTypeId==2) // Services/Business Ads that are NOT 'Jobs', use generic cat_attr template
            catIdToUse = 2999;
         else
            catIdToUse = catId;

         String sqlSelectCatAttr = "select * from cat_attr where cat_id = " + catIdToUse + " order by display_order";
         System.out.println(" **** sqlSelectCatAttr: " + sqlSelectCatAttr);
         
         String sqlSelectCatAttrDetail = "";

         rs = statement.executeQuery(sqlSelectCatAttr);
         boolean found = false;
         while (rs.next())
         {
            catAttr = new CatAttr();

            catAttr.catAttrId = rs.getInt("cat_attr_id");
            catAttr.catAttrName = rs.getString("cat_attr_name");
            catAttr.catAttrLabel = rs.getString("cat_attr_label");
            catAttr.catAttrDesc = rs.getString("cat_attr_desc");
            catAttr.isTitle = rs.getInt("is_title");
            catAttr.isRequired = rs.getInt("is_required");
            catAttr.hasChild = rs.getInt("has_child");
            catAttr.fieldTypeId = rs.getInt("field_type_id");
            catAttr.fieldWidth = rs.getInt("field_width");
            catAttr.maxFieldWidth = rs.getInt("max_field_width");

            catAttrList.add(catAttr);
               
            if (catAttr.hasChild == 1)
            {
               sqlSelectCatAttrDetail = "select * from cat_attr_detail where cat_attr_id = " + catAttr.catAttrId + " order by display_order";
               System.out.println(" **** sqlSelectCatAttrDetail: " + sqlSelectCatAttrDetail);

               rs2 = statement2.executeQuery(sqlSelectCatAttrDetail);
               while (rs2.next())
               {
                  catAttrDetail = new CatAttrDetail();

                  catAttrDetail.catAttrDetailName = rs2.getString("cat_attr_detail_name");
                  catAttrDetail.catAttrDetailLabel = rs2.getString("cat_attr_detail_label");
                  catAttrDetail.catAttrDetailDesc = rs2.getString("cat_attr_detail_desc");

                  catAttrDetail.isRequired = rs2.getInt("is_required");
                  catAttrDetail.fieldTypeId = rs2.getInt("field_type_id");
                  catAttrDetail.fieldWidth = rs2.getInt("field_width");
                  catAttrDetail.maxFieldWidth = rs2.getInt("max_field_width");

                  catAttr.catAttrDetailList.add(catAttrDetail);
               } // while (rs2.next())..
            } // if (catAttr.hasChild == 1)..
            found = true;
         } // while (rs.next())..
         
         session.setAttribute("CATATTRLIST", catAttrList);
      }

      if (grpCatId == 0 && catId == 0)
      {
         System.out.println(" **** grpCatId IS zero: ");
         %>
            <table width=60%>
               <TR><TD><img alt="" src="../images/spacer.gif" height="14" style="display:block "></TD></TR>
               <tr class="chapterHeader"><td>Please select the group-category of interest:</td></tr>
            </table>
            <br>

            <table width="55%"  border="0"  cellspacing="0" cellpadding="0" align="center">
               <tr>
                  <form name="grpCatForm" action="PlaceMsgLoggedIn.jsp" method="POST">
                    <td width="35%" valign="top">Select Group Category:</td>
                    <TD CLASS="JOLButtonInTDWithBorder">
                       <select name="grpCatId" class="Arial10Text" size="1">
                            <%= grpCatOptionsStr %>
                       </select>
                    </td>
                    <td CLASS="JOLButtonInTDWithBorder">  
                       <input type="image" name="submit" src="../images/submit.gif" onClick="document.forms.grpCatForm.submit();"/>
                    </td>
                  </form>
               </TR>
            </table>
         <%
      }
      else if (grpCatId != 0 && catId == 0)
      {
         // System.out.println(" **** grpCatId IS NON zero: " + grpCatId);
         %>
            <table width="95%"  border="0"  cellspacing="0" cellpadding="0" align="center">
               <tr>
                    <td width="2%" valign="top">&nbsp;</td>
                    <td width="95%" valign="top">
                        <table width="90%"  border="0"  cellspacing="0" cellpadding="0" align="center">
                           <TR><TD><img alt="" src="../images/spacer.gif" height="10" style="display:block "></TD></TR>
                           <tr>
                              <TD width=25%>
                                 <table><tr class="chapterHeader"><td style="white-space:nowrap;">GROUP CATEGORY:</td></tr></table>
                              </td>
                              <TD>
                                  <table><tr class="sectionHeader2"><td style="white-space:nowrap;"><%= grpPageHeader %></td></tr></table>
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
                        <td width="95%" valign="top">
                            <table width="90%"  border="0"  cellspacing="0" cellpadding="0" align="center">
                               <TR><TD><img alt="" src="../images/spacer.gif" height="10" style="display:block "></TD></TR>
                               <tr>
                                  <TD width=20% STYLE="white-space: style="white-space:nowrap;";">
                                     <table><tr class="chapterHeader"><td style="white-space:nowrap;">SUB-CATEGORY <%= (i+1) %>:</td></tr></table>
                                  </td>
                                  <TD>
                                      <table><tr class="sectionHeader2"><td style="white-space:nowrap;"><%= pageHeader %></td></tr></table>
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
       %>
            <table width=60%>
               <TR><td width=5%>&nbsp;</td><TD><img alt="" src="../images/spacer.gif" height="1" style="display:block "></TD></TR>
               <tr><td>&nbsp;</td><td class="sectionHeader">Please select a sub-category of interest:</td></tr>
            </table>
            <br>

            <table width="60%" border="0"  cellspacing="0" cellpadding="0" align="center">
               <tr>
                  <form name="catForm" action="PlaceMsgLoggedIn.jsp" method="POST">
                    <td width=5%>&nbsp;</td>
                    <td width="25%" valign="top">Select Category:</td>
                    <TD CLASS="JOLButtonInTDWithBorder" width=30%>
                       <select name="catId" class="Arial10Text" size="1">
                            <%= catOptionsStr %>
                       </select>
                    </td>
                    <td CLASS="JOLButtonInTDWithBorder">  
                       <input type="image" name="submit" src="../images/submit.gif" onClick="document.forms.catForm.submit();"/>
                    </td>
                  </form>
               </TR>
            </table>
         <%
      }
      else if (catId != 0)
      {
%>
   <table width="70%"  border="0"  cellspacing="0" cellpadding="0" align="center">
      <tr>
           <td width="2%" valign="top">&nbsp;</td>
           <td width="95%" valign="top">
               <table width="90%"  border="0"  cellspacing="0" cellpadding="0" align="center">
                  <TR><TD colspan=7><img alt="" src="../images/spacer.gif" height="14" style="display:block "></TD></TR>
                  <tr>
                      <TD width=25%>
                         <table><tr class="chapterHeader"><td style="white-space:nowrap;">GROUP CATEGORY:</td></tr></table>
                      </td>
                      <TD width=2%>&nbsp;</td>
                      <TD width=25%>
                          <table><tr class="chapterHeader"><td style="white-space:nowrap;"><%= grpPageHeader %></td></tr></table>
                      </td>
                      <TD width=2%><img src="../images/arrow.png"/></TD>
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
     
      <TR>
         <td width="5%" valign="top">&nbsp;</td>
         <TD CLASS="sectionHeader">Below is a list of participating businesses in this category within 50 miles of your zipcode:</TD>
         <td valign="top" colspan=2>&nbsp;</td>
      </TR>
   </table>
<%
      } // if (grpCatId == 0 && catId == 0)..
   } // if (userId != 0)..
%>
<jsp:include page="../Footer.jsp?folderLevelDown=1"/>
