<!-- Begin: ReferralSuccess.jsp -->
<%
    String tmp = request.getParameter("nbrReferred");
    int nbrReferred = Integer.parseInt(tmp);

    tmp = request.getParameter("nbrAlreadyReferred");
    int nbrAlreadyReferred = Integer.parseInt(tmp);

    System.out.println("  ******* success: nbrReferred = " + nbrReferred + " nbrAlreadyReferred = " + nbrAlreadyReferred );

    String refEmailHTML = "";
    String alreadyRefEmailHTML = "";

    String strClass = "oddRow1";
    int index = 0;

    for (int i = 0; i < nbrReferred; i++)
    {
        index = (i+1)%4;
        strClass = "oddRow" + (index == 0? 4 : index);

        refEmailHTML += "<tr class=\"" + strClass + "\"><td>" + request.getParameter("refEmailAddr" + i) + "</td></tr>";
    }

    for (int i = 0; i < nbrAlreadyReferred; i++)
    {
        alreadyRefEmailHTML += "<tr class=\"" + strClass + "\"><td>" + request.getParameter("alreadyRefEmailAddr" + i) + "</td></tr>";
    }
%>

<HTML>
<HEAD>
<link href="styles/ttc_style.css" rel="stylesheet" type="text/css">
<link href="styles/ttc_pkm_styles.css" rel="stylesheet" type="text/css">
<script src="flash/flash.js" language="JavaScript" type="text/javascript"></script>
<script src="scripts/AC_RunActiveContent.js" type="text/javascript"></script>
<script src="scripts/LaunchPopUp.js" language="javascript"></script>
</HEAD>
<BODY>
<table width="100%"  border="0" cellspacing="0" cellpadding="0" style="height:100%;">
      <tr>
            <td valign="top">&nbsp;</td>
            <td valign="top" id="main">
                <table width="766"  border="0"  cellspacing="0" cellpadding="0" align="center">
                   <tr>
                        <td valign="top" id="header">
                            <table width="766"  border="0"  cellspacing="0" cellpadding="0" align="center">
                           
                               <tr>
                                    <!-- <td id="flash" VALIGN="TOP"><script language="JavaScript" type="text/javascript">RunFlash();</script> -->
                                    <td id="flash" VALIGN="TOP">&nbsp;
                                         <table width="163"  border="0"  cellspacing="4" cellpadding="4" style="margin-left:5px;">
                                             <TR><td align="CENTER" valign="CENTER" class="blackBorderLightYellowBGAd2Layer" width=60% height=20% style="white-space:nowrap;">Now enrolling<BR>Oct  3rd class!</TD></TR>
                                         </TABLE>
                                         
                                         <table width="163"  border="0"  cellspacing="4" cellpadding="4" style="margin-left:5px;">
                                             <TR><td align="CENTER" valign="CENTER" class="blackBorderLightYellowBGAd2aLayer" width=60% height=20% style="white-space:nowrap;">Limit: First 20/month!<BR>Seats filling fast!!</TD></TR>
                                         </TABLE>
                                         
                                         <table width="163"  border="0"  cellspacing="4" cellpadding="4" style="margin-left:5px;">
                                             <TR><td align="CENTER" valign="CENTER" class="blackBorderLightYellowBGAd3Layer" width=40% height=10% style="white-space:nowrap;">Java/JSP training by a best-selling author!</TD></TR>
                                         </TABLE>
                                    </td>
                                    <td valign="top" id="menu"><img alt=""  src="images/spacer.gif" height="47" style="display:block ">
                                        <table width="347"  border="0"  cellspacing="0" cellpadding="0" style="margin-left:5px;">
                                           <tr>
                                                <TD ALIGN="RIGHT"><IMG SRC="images/logotype_041_640x480_TTCBOY.jpg" width="163" height="100" />&nbsp;&nbsp;</TD>
                                           </tr>
                                            
                                           <tr>
                                                <td valign="top" class="menu">
                                                    <table width="348"  border="0"  cellspacing="0" cellpadding="0" align="center">
                                                        <tr>
                                                            <td valign="top"><img alt=""  src="images/spacer.gif" height="14" style="display:block "><img src="images/list1.gif" alt=" " width="19" height="9" ><a href="about.html" class="">ABOUT</a><img alt=""  src="images/spacer.gif" height="1" style="display:block "><img src="images/border_menu_bot.gif" alt=" " width="144" height="7" ><br><img src="images/list1.gif" alt=" " width="19" height="9" ><a href="FAQ.html" class="">FAQ</a><img alt=""  src="images/spacer.gif" height="1" style="display:block "><img src="images/border_menu_bot.gif" alt=" " width="144" height="7" ><br><img src="images/list1.gif" alt=" " width="19" height="9" ><a href="howItWorks.html" class="">HOW IT WORKS</a><img alt=""  src="images/spacer.gif" height="1" style="display:block "><img src="images/border_menu_bot.gif" alt=" " width="144" height="7" ><br><img src="images/list1.gif" alt=" " width="19" height="9" ><a href="LogOut.jsp" class="">LOG OUT</a><img alt=""  src="images/spacer.gif" height="1" style="display:block "><img src="images/border_menu_bot.gif" alt=" " width="144" height="7" ><br><img src="images/list1.gif" alt=" " width="19" height="9" ><a href="contact.html" class="">CONTACT</a><img alt=""  src="images/spacer.gif" height="1" style="display:block "><img src="images/border_menu_bot.gif" alt=" " width="144" height="7" ><br></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                               </tr>
                            </table>
                        </td>
                   </tr>

                   <tr>
                        <td valign="top" id="cont" align="center">

<!-- Begin: Perfect Link in TD. NOTE: LEFT TD WITH WIDTH=15% VERY IMPORTANT IN AVOIDING EXCESS BACKGROUND SHADING -->    
<table WIDTH=85% BORDER=0 cellpadding="1" cellspacing="8" >
   <tr>
      <TD WIDTH=10%>&nbsp;</TD>
      <td ALIGN="CENTER" class="tableSubHeader" WIDTH=80%><B>Referral Result</B></td>
      <TD CLASS="JOLLinkInTDWithBorder" style="white-space:nowrap;"><A HREF="ManageReferrals.jsp">Manage Referrals</A></TD>
   </TR>
</TABLE>
<!-- End: Perfect Link in TD -->

<SPAN CLASS="font2">Thank you!!</SPAN>

<TABLE WIDTH=65% cellpadding="1" cellspacing="8" border=0>
<%
   if (nbrReferred != 0)
   {
%>
     <TR class="font"><TD>Following individuals have been invited to register at Javaauthor.com. &nbsp;In case any of these individuals registers for paid membership, you will be rewarded upto $150 per paid sign-up:</TD></TR>
     <%= refEmailHTML %>
<%
   }
   if (nbrAlreadyReferred != 0)
   {
%>
      <TR class="font"><TD>Following email addresses already referred by others, or are existing users at Javaauthor.com:</TD></TR>
      <%= alreadyRefEmailHTML %>
<%      
   }
   if (nbrReferred == 0 && nbrAlreadyReferred == 0)
   {
%>
      <TR class="oddRow1"><TD>Sorry, you can't refer to yourself.</TD></TR>
<%      
   }
%>
</TABLE>

                        </TD>
                   </TR>                          
                   <tr>
                        <td valign="top" width="766">
                            <table width="766"  border="0"  cellspacing="0" cellpadding="0" align="center">
                               <tr>
                                    <td valign="top" id="foot">
                                        <table width="728"  border="0"  cellspacing="0" cellpadding="0" align="center">
                                           <tr>
                                                <td valign="top" id="footer" align="center"><img alt=""  src="images/spacer.gif" height="16" style="display:block "/>Copyright 2003-2015 &copy; Javaauthor.com All rights reserved.</td>
                                           </tr>
                                        </table>
                                    </td>
                               </tr>
                            </table>
                        </td>
                   </tr>
                </table>
            </td>
            <td valign="top">&nbsp;</td>
      </tr>
</table>

</BODY>
</HTML>

<!-- End: ReferralSuccess.jsp -->

