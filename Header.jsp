<%@ page import="java.sql.*, shared.*, java.util.*" %>
<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0);
    // response.setHeader("Cache-Control","no-store");

    int isProfile = 0;  
    String strIsProfile = request.getParameter("isProfile");
    if (strIsProfile != null) isProfile = Integer.parseInt(strIsProfile);
   
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

    String rootLevelPrepend = "";

    int nbrFolderLevelDown = 0;  
    String strFolderLevelDown = request.getParameter("folderLevelDown");
    if (strFolderLevelDown != null) nbrFolderLevelDown = Integer.parseInt(strFolderLevelDown);

    for (int i=0; i< nbrFolderLevelDown;i++)
    {
       rootLevelPrepend += "../";
    }

    // System.out.println("\n ####################################### ");
    // System.out.println(" **** Header.jsp: rootLevelPrepend = " + rootLevelPrepend);
                       
    List grpCatList = null;
    //List grpCatList = (List)session.getAttribute("GROUPCATLIST");
    //if (grpCatList == null || grpCatList.size() == 0)
    if (true)
    {
        // System.out.println(" **** Header.jsp: grpCatList is NULL, so will call DBUtils.getGroupCatList()");

        grpCatList = DBUtils.getGroupCatList();
        if (grpCatList != null)
        {
           // System.out.println(" **** Header.jsp: grpCatList is NOT NULL, size: " + grpCatList.size());
           session.setAttribute("GROUPCATLIST", grpCatList);
        }
        // else System.out.println(" **** Header.jsp: grpCatList is NULL");
    }
    // else System.out.println(" **** Header.jsp: grpCatList is NOT NULL, grpCatList.size(): " + grpCatList.size());

    HashMap<Integer,GroupCategoryType> nbrGroupCatHMByType = null;
       // = (HashMap<Integer,GroupCategoryType>)session.getAttribute("NBRGROUPCATSHM");
   
    //if (nbrGroupCatHMByType == null || nbrGroupCatHMByType.size() == 0)
    if (true)
    {
       // System.out.println("**** HEADER: nbrGroupCatHMByType IS null, so will get it from DBUtils");

       nbrGroupCatHMByType = DBUtils.getNbrGroupCatHMByType();

  /*
       if (nbrGroupCatHMByType == null)
          System.out.println("**** HEADER: nbrGroupCatHMByType IS null");
       else
          System.out.println("**** HEADER: nbrGroupCatHMByType IS NOT null");

       System.out.println("**** HEADER: Will put nbrGroupCatHMByType in session");
       */

       session.setAttribute("NBRGROUPCATSHM", nbrGroupCatHMByType);
    }
   // else System.out.println(" **** Header.jsp: nbrGroupCatHMByType is NOT NULL, nbrGroupCatHMByType.size(): " + nbrGroupCatHMByType.size());
   
%>
<!-- <!DOCTYPE html> -->
<HTML>
<HEAD>
<TITLE>One-stop site that connects Credit Card Issuers, Retail Businesses and Individuals!</TITLE>
<META name="description" content="rewards,rewards for referrals,checkout discount,credit card issuer,retailer,restaurants,department store,grocery,increase revenue">
<META name="keywords" content="rewards,rewards for referrals,checkout discount,credit card issuer,retailer,restaurants,department store,grocery,increase revenue">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<link href="<%= rootLevelPrepend %>styles.css" rel="stylesheet" type="text/css">
<link href="<%= rootLevelPrepend %>style.css" rel="stylesheet" type="text/css">
<link href="<%= rootLevelPrepend %>style_body_new.css" rel="stylesheet" type="text/css">
<link href="<%= rootLevelPrepend %>styles/pkm_styles.css" rel="stylesheet" type="text/css">
<link href="<%= rootLevelPrepend %>css/reset.css" rel="stylesheet" type="text/css" media="screen">
<link href="<%= rootLevelPrepend %>css/style.css" rel="stylesheet" type="text/css" media="screen">
<!--
<link rel="stylesheet" type="text/css" href="styles/styles1.css" />
<link rel="stylesheet" type="text/css" href="styles/styles.css" />
-->
<script language="javascript">
function dump()
{
   alert(window.innerWidth); // 1366
   alert(window.innerHeight); // 633
   // console.log(`Width: ${width}px, Height: ${height}px`);
}
</script>
</HEAD>
<!-- <body onload="dump();"> -->
<body>
<table border="1" cellspacing="0" cellpadding="0" style="height:100%;" ALIGN="center" WIDTH="100%">
<tr>
<td id="leftBar" width=10% >&nbsp;</td>
<td width=78% id="cont1New">
                <table cellspacing="1" cellpadding="1" height="100%" width=95%>  <!-- Width here is critical  -->
                   <tr>
                        <td valign="top" id="cont1New" WIDTH=5% >&nbsp;</td>
                        <td valign="top" id="header"><img src="<%= rootLevelPrepend %>images/spacer.gif" height="2px" style="display:block ">
                        <%-- <td valign="top" width=60% ><img src="<%= rootLevelPrepend %>images/spacer.gif" height="2px" style="display:block "> --%>
                                                   
                                       <table cellspacing="2" cellpadding="2" width=100% >
                                           <tr>
                                                <td width=90%>&nbsp;
                                                   <!-- <header> -->
                                                      <table cellspacing="4" cellpadding="4" width=90% >
                                                         <tr>
                                                            <td class="slider-wrapper">
                                                              <table cellspacing="4" cellpadding="4" width=90%>                    
                                                                 <tr>
                                                                    <!-- <td class="slider_old"> -->
                                                                    <td>
                                                                        <div class="slider">
                                                                            <img class="slides2" src="<%= rootLevelPrepend %>images/new/unet_img1.PNG" style=" display:block;">  <!-- TEMP COMMENTED OUT -->
                                                                            <%-- <img class="slides2" src="<%= rootLevelPrepend %>images/new/unet_img1.PNG" style="display:none;"> --%> <!-- TEMP ONLY -->
                                                                            <img class="slides2" src="<%= rootLevelPrepend %>images/new/unet_img2.PNG" style=" display:none;">
                                                                            <img class="slides2" src="<%= rootLevelPrepend %>images/new/unet_img3.jpg" style=" display:none;">
                                                                            <img class="slides2" src="<%= rootLevelPrepend %>images/new/unet_img4.jpg" style=" display:none;">
                                                                            <img class="slides2" src="<%= rootLevelPrepend %>images/new/unet_img5.jpg" style=" display:none;">
                                                                        </div>
                                                               
                                                                        <br><br>
                                                                        <input type="button" class="btn btn-primary" onclick="changeSlide('previous')" value="Previous" style="display: none;">
                                                                        <input type="button" class="btn btn-success" id="myHiddenButton" onclick="slideshow(this)" value="Start Slideshow" style="display:none;">
                                                                        <input type="button" class="btn btn-primary" onclick="changeSlide('next')" value="Next" style="display: none;">
                                                                    </td>
                                                                 </tr>
                                                              </table>        
                                                            </td>
                                                         </tr>
                                                      </table>        
                                                   <!-- </header> -->
                                                   <script type="text/javascript">
                                                      var slideIndex = 0;
                                                      showSlides();
                                                     
                                                      function showSlides()
                                                      {
                                                         slides = document.getElementsByClassName("slides2");
                                                         
                                                         for (i = 0; i < slides.length; i++)
                                                         {
                                                            slides[i].style.display = "none";
                                                         }
                                                         slideIndex++;
                                                         if (slideIndex > slides.length) {slideIndex = 1;}
                                                         slides[slideIndex-1].style.display = "block";  // TEMP COMMENTED OUT
                                                         setTimeout(showSlides, 3000); // Change image every 3 seconds // TEMP COMMENTED OUT
                                                         
                                                         // slides[slideIndex-1].style.display = "none"; // TEMP ONLY
                                                      }
                                                   </script>
                                                   <table cellspacing="2" cellpadding="2" width=90% >
                                                       <tr>
                                                          <td width=35% >&nbsp;</TD>
                                                          <td valign="top" class="tahoma10FontHomeMenu" width=20% style="white-space:nowrap;"><img alt="" src="<%= rootLevelPrepend %>images/spacer.gif" height="8px" style="display:block ">
                                                             <img src="<%= rootLevelPrepend %>images/list1.gif" alt=" " width="19" height="9" ><a href="<%= rootLevelPrepend %>index.jsp" class="">HOME</a><img alt=""  src="<%= rootLevelPrepend %>images/spacer.gif" height="1" style="display:block "><img src="<%= rootLevelPrepend %>images/border_menu_bot.gif" alt=" " width="144" height="7" ><br>
                                                          <%
                                                             int tdBlockCnt = 0;
                                                             // int catsPerBlock = 7;
                                                             int catsPerBlock = 5;
                                                             //int catsPerBlockToUse = 0;
                                                             int catsAddedThisBlock = 0;
                                                             GroupCategory grpCat = null;

                                                             if ((userId ==0 && businessId == 0) && grpCatList != null)
                                                             {
                                                                for (int i=0; i < grpCatList.size(); i++)
                                                                {
                                                                   grpCat = (GroupCategory)grpCatList.get(i);
                                                                   // String str = "<img src=" + rootLevelPrepend + "images/list1.gif alt=\" \" width=\"19\" height=\"9\" ><a href=\"" + rootLevelPrepend + "usermgt/PlaceMsg.jsp?grpCatId=" + grpCat.grpCatId + " class=\"\">" + grpCat.grpCatLabel + "</a><img src=\"" + rootLevelPrepend + "images/spacer.gif height=\"1\" style=\"display:block\"><img src=\"" + rootLevelPrepend + "images/border_menu_bot.gif width=\"144\" height=\"7\"><br>";
                                                                   // System.out.println(" **** i: " + i + ", grpCat.grpCatId: " + grpCat.grpCatId + ", grpCat.grpCatLabel: " + grpCat.grpCatLabel + ", str: " + str);
                                                          %>
                                                                   <img src="<%= rootLevelPrepend %>images/list1.gif" width="19" height="9" ><a href="<%= rootLevelPrepend %>usermgt/SelectCat.jsp?grpCatId=<%= grpCat.grpCatId %>" class=""><%= grpCat.grpCatLabel %></a><img alt=""  src="<%= rootLevelPrepend %>images/spacer.gif" height="1" style="display:block "><img src="<%= rootLevelPrepend %>images/border_menu_bot.gif" alt=" " width="144" height="7" ><br>
                                                          <%
                                                                   catsAddedThisBlock++;
                                                                   //if (tdBlockCnt ==0) catsPerBlockToUse = catsPerBlock;
                                                                   //else catsPerBlockToUse = catsPerBlock-1;
                                                                   // if (i > 0 && catsAddedThisBlock == catsPerBlock)
                                                                   if (catsAddedThisBlock == catsPerBlock)
                                                                   {
                                                                      tdBlockCnt++;
                                                                      // if (tdBlockCnt == 1) catsPerBlock = 8;
                                                                      if (tdBlockCnt == 1) catsPerBlock = 6;

                                                                      // System.out.println(" **** BLOCK CNT: " + tdBlockCnt + " ENDED, i: " + i + ", catsPerBlock for next block: " + catsPerBlock + ", catsAddedThisBlock: " + catsAddedThisBlock);

                                                                      catsAddedThisBlock = 0;
                                                                      //if (i != grpCatList.size()-1)
                                                                      //{
                                                                         // System.out.println(" **** i: " + i + ", grpCatList.size(): " + grpCatList.size() + ", WILL ADD NEW TD BLOCK");
                                                          %>
                                                                         </td>
                                                                         <td width=1% >&nbsp;</TD>
                                                                         <td valign="top" class="tahoma10FontHomeMenu" width=20% ><img alt="" src="<%= rootLevelPrepend %>images/spacer.gif" height="8px" style="display:block ">
                                                          <%
                                                                      //} // if (i != catList.size()-1)..
                                                                   } // if (i > 0 &&..
                                                                } // for (int i=0..
                                                             } //if (grpCatList != null)
                                                          %>
                                                         
                                                          <img src="<%= rootLevelPrepend %>images/list1.gif" width="19" height="9" ><a style="white-space:nowrap;" href="<%= rootLevelPrepend %>usermgt/Rewards.jsp">REWARDS/REFERRALS/HOW IT WORKS</a><img src="<%= rootLevelPrepend %>images/spacer.gif" height="1" style="display:block "><img src="<%= rootLevelPrepend %>images/border_menu_bot.gif" alt=" " width="144" height="5" ><br>

                                                          <%
                                                             if (userId ==0 && businessId == 0) // NOT Logged in
                                                             {
                                                          %>  
                                                                <img src="<%= rootLevelPrepend %>images/list1.gif" width="19" height="9" ><a href="<%= rootLevelPrepend %>usermgt/Register.jsp" class="">REGISTER</a> / <a href="<%= rootLevelPrepend %>usermgt/Login.jsp" class="">LOGIN</a><img src="<%= rootLevelPrepend %>images/spacer.gif" height="1" style="display:block "><img src="<%= rootLevelPrepend %>images/border_menu_bot.gif" alt=" " width="144" height="7" ><br>
                                                                <%-- <img src="<%= rootLevelPrepend %>images/list1.gif" alt=" " width="19" height="9" ><a href="<%= rootLevelPrepend %>usermgt/SampleRewards.jsp">DEMO</a> / <a href="<%= rootLevelPrepend %>Contact.jsp" class="">CONTACT</a><img src="<%= rootLevelPrepend %>images/spacer.gif" height="1" style="display:block "><img src="<%= rootLevelPrepend %>images/border_menu_bot.gif" alt=" " width="144" height="5" ><br> --%>
                                                                <img src="<%= rootLevelPrepend %>images/list1.gif" width="19" height="9" ><a href="<%= rootLevelPrepend %>usermgt/Demo.jsp" class="">DEMO</a> / <a href="<%= rootLevelPrepend %>Contact.jsp" class="">CONTACT</a><img src="<%= rootLevelPrepend %>images/spacer.gif" height="1" style="display:block "><img src="<%= rootLevelPrepend %>images/border_menu_bot.gif" width="144" height="5" ><br>
                                                          <%
                                                             }
                                                             else // Logged in
                                                             {
                                                                if (isProfile == 0) // Logged in, but NOT View Profile page
                                                                {
                                                          %>  
                                                                   <img src="<%= rootLevelPrepend %>images/list1.gif" width="19" height="9" ><a href="<%= rootLevelPrepend %>usermgt/ViewProfile.jsp">MY PROFILE</a><img src="<%= rootLevelPrepend %>images/spacer.gif" height="1" style="display:block "><img src="<%= rootLevelPrepend %>images/border_menu_bot.gif" alt=" " width="144" height="5" ><br>
                                                          <%
                                                                }
                                                          %>
                                                                <img src="<%= rootLevelPrepend %>images/list1.gif" width="19" height="9" ><a href="<%= rootLevelPrepend %>usermgt/Demo.jsp">DEMO</a><img src="<%= rootLevelPrepend %>images/spacer.gif" height="1" style="display:block "><img src="<%= rootLevelPrepend %>images/border_menu_bot.gif" alt=" " width="144" height="5" ><br>
                                                                <img src="<%= rootLevelPrepend %>images/list1.gif" width="19" height="9" ><a href="<%= rootLevelPrepend %>usermgt/LogOut.jsp" class="">LOG OUT</a> / <a href="<%= rootLevelPrepend %>Contact.jsp" class="">CONTACT</a><img src="<%= rootLevelPrepend %>images/spacer.gif" height="1" style="display:block "><img src="<%= rootLevelPrepend %>images/border_menu_bot.gif" alt=" " width="144" height="7" >
                                                          <%
                                                             } // if (userId ==0 &&..
                                                          %>
                                                             
                                                             <%-- <IMG SRC="<%= rootLevelPrepend %>images/new/Rewards2Connect.png"/> --%>
                                                          </td>
                                                          <%-- <td valign="top" class="tahoma10FontHomeMenu" width=20%><IMG SRC="<%= rootLevelPrepend %>images/new/Rewards2Connect.png" width="159px" height="52px"/></td> --%>
                                                          <td width=2% >&nbsp;</td>
                                                       </tr>
                                                   </table>
                                                <!-- </TD>
                                                <td valign="top"> -->
                                                </td>
                                           </tr>
                                       </table>
                        </td>
                        <td valign="top" id="cont1New">&nbsp;</td>
                   </tr>
                   <tr>
                        <td valign="top" id="cont1New" WIDTH="3%">&nbsp;</td>
                        <td valign="top" id="contNew" align="left" width=100% >
