<%@ page import="java.sql.*, shared.*, java.util.*" %>

<%
    System.out.println("#################  in logout jsp");

    session.removeAttribute("USERID");
    session.removeAttribute("SECTIONID");
    session.removeAttribute("MAXLESSONID");
    // session.removeAttribute("ISBOTHENABLED");
    
    session.removeAttribute("JAVABEGSECTID");
    session.removeAttribute("JAVABEGMAXLESS");
    session.removeAttribute("JAVABEGSTARTDATE");
    session.removeAttribute("JAVABEGEXTENDED");
    session.removeAttribute("JAVABEGPROCTORED");
    session.removeAttribute("JAVABEGFINALENABLED");
    session.removeAttribute("JAVABEGFINALPWD");
	session.removeAttribute("JAVABEGDAYSTONEXT");

    session.removeAttribute("JAVAADVSECTID");
    session.removeAttribute("JAVAADVMAXLESS");
    session.removeAttribute("JAVAADVSTARTDATE");
    session.removeAttribute("JAVAADVEXTENDED");
    session.removeAttribute("JAVAADVPROCTORED");
    session.removeAttribute("JAVAADVFINALENABLED");
    session.removeAttribute("JAVAADVFINALPWD");
	session.removeAttribute("JAVAADVDAYSTONEXT");

    session.removeAttribute("JAVAADV2SECTID");
    session.removeAttribute("JAVAADV2MAXLESS");
    session.removeAttribute("JAVAADV2STARTDATE");
    session.removeAttribute("JAVAADV2EXTENDED");
    session.removeAttribute("JAVAADV2PROCTORED");
    session.removeAttribute("JAVAADV2FINALENABLED");
    session.removeAttribute("JAVAADV2FINALPWD");
	session.removeAttribute("JAVAADV2DAYSTONEXT");

    session.removeAttribute("JSPSECTID");
    session.removeAttribute("JSPMAXLESS");
    session.removeAttribute("JSPSTARTDATE");
    session.removeAttribute("JSPEXTENDED");
    session.removeAttribute("JSPPROCTORED");
    session.removeAttribute("JSPFINALENABLED");
    session.removeAttribute("JSPFINALPWD");
	session.removeAttribute("JSPDAYSTONEXT");

    session.removeAttribute("JSPADVSECTID");
    session.removeAttribute("JSPADVMAXLESS");
    session.removeAttribute("JSPADVSTARTDATE");
    session.removeAttribute("JSPADVEXTENDED");
    session.removeAttribute("JSPADVPROCTORED");
    session.removeAttribute("JSPADVFINALENABLED");
    session.removeAttribute("JSPADVFINALPWD");
	session.removeAttribute("JSPADVDAYSTONEXT");

    session.removeAttribute("ISADMIN");
    session.removeAttribute("CNTENABLED");
    session.removeAttribute("COURSELESSONMENU");
    session.removeAttribute("CHAPTERLESSONMENU");
    session.removeAttribute("TOPLEVELRLESSONMENU");

    session.removeAttribute("ISDEMO");
    session.removeAttribute("EXTENDED");
    session.removeAttribute("PROCTORED");
    session.removeAttribute("DAYSTONEXT");
    session.removeAttribute("FINALENABLED");
    session.removeAttribute("FINALPWD");
	session.removeAttribute("SWITCH");

    session.removeAttribute("ISADMIN");
    session.removeAttribute("CNTENABLED");
    session.removeAttribute("COURSEIDSENABLED");
    session.removeAttribute("COURSELESSONMENU");
    session.removeAttribute("CHAPTERLESSONMENU");   
    session.removeAttribute("TOPLEVELRLESSONMENU");

    session.setMaxInactiveInterval(60 * 60); // half hour
%>
<HTML>
<HEAD>
<SCRIPT LANGUAGE="JAVASCRIPT">
function logOut()
{
   top.location= "index.html";
   //top.location= "http://javaonline.org";
   //top.location= "/";
}

</script>
    
</HEAD>
<BODY ONLOAD="logOut();">

</BODY>
</HTML>









