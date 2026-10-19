<%@ page import="java.sql.*, shared.*, java.util.*" %>
<jsp:include page="Header.jsp"/>

<%
    int userId = 0;
    Integer intUserId = (Integer)session.getAttribute("USERID");
    if (intUserId != null)
    {
       userId = intUserId.intValue();
    }
   
    int businessId = 0;
    Integer intBusinessId = (Integer)session.getAttribute("BUSINESSID");
    if (intBusinessId != null)
    {
       businessId = intBusinessId.intValue();
    }

    GroupCategory grpCat = null;
    Category cat = null;
    List grpCatList = (List)session.getAttribute("GROUPCATLIST");
    HashMap<Integer,GroupCategoryType> nbrGroupCatHMByType
       = (HashMap<Integer,GroupCategoryType>)session.getAttribute("NBRGROUPCATSHM");
    System.out.println("------------------------------------");

    if (grpCatList == null)
       System.out.println("****** INDEX: grpCatList IS null");
    else
       System.out.println("****** INDEX: grpCatList IS NOT null, grpCatList.size(): " + grpCatList.size());

    if (nbrGroupCatHMByType == null)
       System.out.println("****** INDEX: nbrGroupCatHMByType IS null");
    else
       System.out.println("****** INDEX: nbrGroupCatHMByType IS NOT null");

    int grpCatTypeId = 1, prevGrpCatTypeId = 0, prevGrpCatId = 0;
    GroupCategoryType gct = nbrGroupCatHMByType.get(grpCatTypeId);  
    System.out.println("****** gct.grpCatTypeDesc: " + gct.grpCatTypeDesc);
%>
      <table width="100%"  border="0"  cellspacing="2" cellpadding="2" align="center">
         <tr>
              <td width="1%" valign="top">&nbsp;</td>
             
              <td width=95% valign="top">  <!-- Width here is critical  -->
                  <table width="100%"  border="0"  cellspacing="3" cellpadding="3" align="center">
                     <!--
                     <TR><TD COLSPAN=2><img src="images/spacer.gif" height="4" style="display:block"></TD></TR>
                     <TR CLASS="JOLTextInTD14pxWithBorder"><TD width=80% colspan=2 style="white-space:nowrap;">&nbsp;&nbsp;&nbsp;OVERVIEW<img src="images/spacer.gif" height="2" style="display:block"></TD></TR>
                     <TR><TD COLSPAN=2><img src="images/spacer.gif" height="14" style="display:block"></TD></TR>
                     -->
                     <tr>
                        <td width=75% valign="top">
                              <table><tr><td>To see sample screen-shots in action, click on the "DEMO" button on the right &#x21E8;</td><td class="sectionHeader5_Button_w2pxBorder"><img src="images/spacer.gif" height="2px" style="display:block"><a href="usermgt/Demo.jsp">DEMO</A></td></tr></table>
                              
                              <table width="95%"  border="0"  cellspacing="2" cellpadding="2" align="center">
                                 <TR><TD><img src="images/spacer.gif" height="4" style="display:block "></TD></TR>
                                 <TR class="JOLTextInTD14pxWithBorder">
                                     <td valign="top" style="white-space:nowrap;"><img src="images/spacer.gif" height="2" style="display:block">&nbsp;&nbsp;&nbsp;SUMMARY<img src="images/spacer.gif" height="2" style="display:block"></TD>
                                 </TR>
                                 <tr>
                                      <td valign="top">
                                          <TABLE width=100%><img src="images/spacer.gif" height="2" style="display:block">
                                             <TR><td width=3%>&bull;</td><td>Customers can now generate discount coupons (UPC Barcodes) to get discount at checkout or reduce finance charges based on referrals.</td></tr>
                                             <TR><td width=3%>&bull;</td><td>Any business or user anywhere in the whole world can use it to increase revenue thro referrals / get discounts thro coupons (respectively).</td></tr>
                                             <TR><td width=3%>&bull;</td><td>The user gets the checkout discount only if other referred users sign up and spend, so it is a win-win situation for both the business and users.</td></tr>
                                             <TR><td width=3%>&bull;</td><td>The business gets more customers and increases revenue.</td></tr>
                                             <TR><td width=3%>&bull;</td><td>Rewards2Connect tracks the referrals and one gets cash even from other referred user's referrals. It goes 2 levels down, so it is a referral cascade.</td></tr>
                                             <TR><td width=3%>&bull;</td><td>Same thing with credit card issuers such as banks: user refers others who sign up for credit cards and gets cash back if those referrals pay finance charges to offset such cash back.</td></tr>
                                             <TR><td width=3%>&bull;</td><td>Don't have finance charges or don't plan to purchase at retailers?&nbsp;That's ok, you can STILL make money by just referring others who spend!</td></tr>
                                             <TR><td width=3%>&bull;</td><td>The sky is the limit for such cash backs.. you could make $1000's or more each month because you actually getting a fraction of the bank or retailer's profits!</td></tr>
                                          </table>
                                      </td>
                                 </tr>
                              </table>   
                                                                             
                              <table width="95%"  border="0"  cellspacing="2" cellpadding="2" align="center">
                                 <TR><TD><img src="images/spacer.gif" height="4" style="display:block "></TD></TR>
                                 <TR class="JOLTextInTD14pxWithBorder">
                                     <td valign="top" style="white-space:nowrap;"><img src="images/spacer.gif" height="2" style="display:block">&nbsp;&nbsp;&nbsp;OVERVIEW<img src="images/spacer.gif" height="2" style="display:block"></TD>
                                 </TR>
                                 <tr>
                                      <td valign="top"><br>
                                          <table width=100%><tr class="sectionHeader5_Button"><td>&nbsp;INDIVIDUALS</td></tr></table>
                                          <img src="images/spacer.gif" height="6" style="display:block "/>Use Rewards2Connect to generate coupon codes that you can use:<br>
                                          <TABLE width=100%>
                                             <TR><td width=3%>&bull;</td><td>To get cash back from finance charges when paying your credit card balance every month at participating credit card issuing banks, and/or</td></tr>
                                             <TR><td width=3%>&bull;</td><td>To get an instant discount at checkout counters of participating grocery, department stores and restaurants!</td></tr>
                                          </table>
                                          <img src="images/spacer.gif" height="6" style="display:block "/>
                                       
                                          <table width=100%><tr class="sectionHeader5_Button"><td>&nbsp;CREDIT CARD ISSUERS (BANKS/CREDIT UNIONS)</td></tr></table>
                                             <img src="images/spacer.gif" height="6" style="display:block "/>Use Rewards2Connect to register as a participating credit card issuing bank or credit union:<br>
                                             <TABLE width=100%>
                                                <TR><td width=3%>&bull;</td><td>To recognize Rewards2Connect.com coupon codes from your existing or new customers, so that you give them cash back (small portion deducted) from finance charges when paying their credit card balance each month.</td></tr>
                                                <TR><td width=3%>&bull;</td><td>Note that you give a cash back only if at least one from user's referrals got approved for a credit card at your bank/credit union and the sum of finance charges from such referred, approved user(s) for that cycle exceeds the potential cash back from finance charges of the original user.</td></tr>
                                                <TR><td width=3%>&bull;</td><td>Your existing or new customers can refer other customers to apply for your credit card by sending them a Rewards2Connect.com URL and earn further cash back from such referred customers' finance charges from balances.</td></tr>
                                             </table>
                                             <img src="images/spacer.gif" height="6" style="display:block "/>
                                          <img src="images/spacer.gif" height="6" style="display:block "/>
                                         
                                          <table width=100%><tr class="sectionHeader5_Button"><td>&nbsp;RESTAURANTS/RETAIL/GROCERY/DEPT STORES/SERVICES</td></tr></table>
                                             <img src="images/spacer.gif" height="6" style="display:block "/>Use Rewards2Connect.com to register as a participating retail/service/restaurant business:<br>
                                             <TABLE width=100%>
                                                <TR><td width=3%>&bull;</td><td>Potential customers can generate coupon codes specific to your business that they can use at checkout.&nbsp;So you increase your customer base by getting new customers.&nbsp;Also existing customers can register at Rewards2Connect.com and select your business as the destination while generating the coupon code.</td></tr>
                                                <TR><td width=3%>&bull;</td><td>Your existing or new customers can refer other customers to visit your business by sending them a Rewards2Connect.com URL and earn further cash backs from such referred customers' transactions at your business.</td></tr>
                                             </table>
                                             <img src="images/spacer.gif" height="6" style="display:block "/>
                                       </td>
                                 </tr>
                              </table>

                              <hr>
                              <br>
                              <table width="95%"  border="0"  cellspacing="2" cellpadding="2" align="center">
                               
                                 <TR><TD><img src="images/spacer.gif" height="4" style="display:block "></TD></TR>
                                 <TR class="JOLTextInTD14pxWithBorder">
                                     <td valign="top" style="white-space:nowrap;"><img src="images/spacer.gif" height="2" style="display:block">&nbsp;&nbsp;UNIQUE FEATURES&nbsp;&nbsp;<img src="images/spacer.gif" height="2" style="display:block"></TD>
                                 </TR>
                                 <tr>
                                      <td valign="top"><br>
                                          <table width=100%><tr class="sectionHeader5_Button"><td>&nbsp;Multi-purpose&nbsp;</td></tr></table>
                                         
                                          <!-- Welcome to a new way of networking!  This is a one-stop site to put your skills, resumes, jobs available, business or services offered or looking for, homes or land for sale or purchase, personal relationships, matrimonials, or simply add favorites from the net or your family events, birthday celebrations, marriages, reception parties, etc. to add and share with others in your group!<br> -->
                                          Welcome to a new way of saving money each month! Get cash back at participating credit card issuing banks or credit unions.&nbsp;Or get an instant discount at participating grocery/department stores, restaurants and other services!<br>
                                         
                                          <img src="images/spacer.gif" height="6" style="display:block "/>
                                       
                                          <table width=100%><tr class="sectionHeader5_Button"><td>&nbsp;100% Free&nbsp;</td></tr></table>
                                             All discount coupon generation here is 100% free, so there is nothing to lose!
                                             <img src="images/spacer.gif" height="6" style="display:block "/>

                                          <img src="images/spacer.gif" height="6" style="display:block "/>
                                         
                                          <table width=100%><tr class="sectionHeader5_Button"><td>Localized to focus on your area&nbsp;</td></tr></table>
                                             The credit card issuing banks and credit unions could be either local to your area or could be national level.<br><br>
                                             The retail stores/restaurants/services that participate are either national chains or single location businesses in your local area or zip code.  But online participating retailers could be located anywhere in the world .. so the sky is the limit!
                                             <img src="images/spacer.gif" height="6" style="display:block "/>
                                       </td>
                                 </tr>
                              </table>
                        </td>
                        <td>
                    <%
                       if (userId ==0 && businessId == 0) // NOT Logged in
                       {
                    %>  
                              <table  border="0" cellspacing="2" cellpadding="2" width=100% >
                                  <tr>
                                     <!-- <td width=1% >&nbsp;</TD> -->
                                     <td valign="top" style="white-space:nowrap;"><img src="images/spacer.gif" height="8px" style="display:block ">
                                     
                                         <table cellspacing="2" cellpadding="2" width=85%>
                                            <tr class="sectionHeader2wBorder"><td>&nbsp;<%= gct.grpCatTypeDesc %></td></tr>
                                           
                                            <tr><td class="tahoma10FontHomeMenuReverse">
                                     <%
                                        // int catsPerBlock = 7;
                                        int catsPerBlock = gct.nbrGrpCatType;
                                        int catsAddedThisBlock = 0;
                                        String rowClass= "sectionHeader5";
                                        for (int i=0; i < grpCatList.size(); i++)
                                        {
                                           grpCat = (GroupCategory)grpCatList.get(i);
                                           grpCatTypeId = grpCat.grpCatTypeId;
                                           // System.out.println(" **** i: " + i + ", grpCatTypeId: " + grpCatTypeId + ", grpCat.grpCatId: " + grpCat.grpCatId + ", prevGrpCatId: " + prevGrpCatId);
                                           
                                           // if (prevGrpCatTypeId != 0 && grpCatTypeId != prevGrpCatTypeId)
                                           if (prevGrpCatId != 0 && grpCat.grpCatId != prevGrpCatId)                                                
                                           {
                                              gct = nbrGroupCatHMByType.get(grpCatTypeId);
                                              catsPerBlock = gct.nbrGrpCatType;
                                              catsAddedThisBlock = 0;

                                              // System.out.println(" **** NEW catsPerBlock: " + catsPerBlock + ", grpCat.grpCatId: " + grpCat.grpCatId + ", gct.grpCatTypeDesc: " + gct.grpCatTypeDesc);
                                     %>
                                                   </td></tr>
                                                   <tr><td class="tahoma10FontHomeMenuWBottomBorder">&nbsp;</td></tr>
                                                </table>
                                              </td>  
                                           </tr>
                                           <tr>
                                           <!-- <td class="tahoma10FontHomeMenuWBottomBorder">&nbsp;</td></tr> -->
                                              <!-- <td width=2% valign="top"></td> -->
                                              <td valign="top" style="white-space:nowrap;"><img src="images/spacer.gif" height="8px" style="display:block ">
                                                 <table cellspacing="2" cellpadding="2" width=85%>
                                                     <tr class="sectionHeader2wBorder"><td>&nbsp;<%= gct.grpCatTypeDesc %></td></tr>
                                                     
                                                     <tr><td class="tahoma10FontHomeMenuReverse">
                                     <%
                                           }
                                     %>
                                           <!-- <img src="images/img6.gif" alt=" " width="165" height="53" > -->
                                           <img src="images/spacer.gif" height="10" style="display:block ">
                                           &nbsp;<a class="sectionHeader7" href="usermgt/SelectCat.jsp?grpCatId=<%= grpCat.grpCatId %>">&nbsp;<%= grpCat.grpCatLabel %>&nbsp;</a><img src="images/spacer.gif" height="5" style="display:block"><img src="images/border_menu_bot.gif" alt=" " width="184" height="7" ><br>
                                     <%
                                           for (int j=0; j < grpCat.catList.size(); j++)
                                           {
                                              cat = (Category)grpCat.catList.get(j);
                                     %>
                                                 &nbsp;&nbsp;<img src="images/list1.gif" alt=" " width="19" height="9" >&nbsp;<a href="usermgt/SelectCat.jsp?catId=<%= cat.catId %>"><%= cat.catLabel %></a><img src="images/spacer.gif" height="1" style="display:block"><img src="images/border_bot.gif" alt=" " width="149" height="5" >
                                     <%
                                              if (j != grpCat.catList.size()-1)
                                              {
                                     %>
                                                 <br>
                                     <%
                                              }
                                              if (rowClass.equals("sectionHeader5"))
                                              {
                                                 rowClass = "sectionHeader6";
                                              }
                                              else rowClass = "sectionHeader5";

                                           } // for (int j=0; j < grpCat.catList.size()..
                                           
                                           catsAddedThisBlock++;
                                           prevGrpCatTypeId = grpCatTypeId;
                                           prevGrpCatId = grpCat.grpCatId;
                                           
                                           if (catsAddedThisBlock < catsPerBlock)
                                           {
                                     %>
                                             <br>
                                     <%
                                           } // if (catsAddedThisBlock < catsPerBlock)..
                                        } // for (int i=0; i < grpCatList.size()..
                                     %>
                                             </td></tr>
                                             <tr><td class="tahoma10FontHomeMenuWBottomBorder">&nbsp;</td></tr>
                                         </table>
                                     </td>
                                  </tr>
                              </table>
                    <%
                       }
                    %>
                        </td>
                     </tr>
                  </table>
              </td>
             
              <!-- <td width="10%" valign="top">&nbsp;</td> -->
              <td width="1%" valign="top">&nbsp;</td>
             
              <td valign="top"></td>
         </tr>
      </table>
<jsp:include page="Footer.jsp"/>
