<%@ page import="java.sql.*, java.util.*, shared.*" %>
<%
    String countryName = "";
    String metroAreaName = "";
       
    String countryOptionStr = "";

    Country[] countryList = (Country[])session.getAttribute("COUNTRYLIST");

    if (countryList == null)
    {
       countryList = NavUtils.getCountryList();
    }
    System.out.println(" ******************************************** ");
    System.out.println(" **** REGISTER.JSP ******");

    System.out.println(" **** countryList is NOT null: size: " + countryList.length);

    session.setAttribute("COUNTRYLIST", countryList);
   
    Country ctry = null;

    for (int i=0; i < countryList.length; i++)
    {
       ctry = (Country)countryList[i];
       if (i == 0)
       {
          countryOptionStr += "<option selected=\"1\" value=\"" + ctry.getCode() + "_" + ctry.getName() + "\">" + ctry.getName() + "</option>\n";
       }
       else
       {
          countryOptionStr += "<option value=\"" + ctry.getCode() + "_" + ctry.getName() + "\">" + ctry.getName() + "</option>\n";
       }      
    }

   String strGrpCatId = request.getParameter("GRP_CAT_ID");

   int grpCatId = 1100;
   if (strGrpCatId != null && !strGrpCatId.equals(""))
   {
      grpCatId = Integer.parseInt(strGrpCatId);
   }
   System.out.println("**** Register.jsp: FROM REQUEST: grpCatId: " + grpCatId);

   String strCatId = request.getParameter("CAT_ID");      

   int catId = 0;
   if (strCatId != null && !strCatId.equals(""))
   {
      catId = Integer.parseInt(strCatId);
   }
   System.out.println("**** Register.jsp: FROM REQUEST: catId: " + catId);
   
   List<GroupCategory> grpCatList = (List<GroupCategory>)session.getAttribute("GROUPCATLIST");

   if (grpCatList == null)
   {
      System.out.println(" **** grpCatList is null: ");  
      grpCatList = DBUtils.getGroupCatList();
   }

   System.out.println(" **** grpCatList is NOT null: size: " + grpCatList.size());

   session.setAttribute("GROUPCATLIST", grpCatList);

   Category cat = null;
   GroupCategory grpCat = null;

   String grpCatOptionsStr = "";

   for (int i=0; i < grpCatList.size(); i++)
   {
      grpCat = (GroupCategory)grpCatList.get(i);
      if (grpCatId == grpCat.grpCatId)
      {
        grpCatOptionsStr += "<option selected=\"1\" value=\"" + grpCat.grpCatId + "\">" + grpCat.grpCatName + "</option>\n";
      }
      else
      {
        grpCatOptionsStr += "<option value=\"" + grpCat.grpCatId + "\">" + grpCat.grpCatName + "</option>\n";
      }      
   }    

   // System.out.println(" **** grpCatOptionsStr: " + grpCatOptionsStr);  
   
   String catOptionsStr = "";
   List<Category> catList = null;

   if (grpCatId != 0 && catId == 0)
   {
      System.out.println(" **** grpCatId IS NON zero: " + grpCatId);

      catList = DBUtils.getCatListbyGroupCatId(grpCatId);

      if (catList != null)
      {
         System.out.println(" **** catList is NOT null, len = " + catList.size());

         for (int i=0; i < catList.size(); i++)
         {
           cat = (Category)catList.get(i);

           if (i == 0)
           {
             catOptionsStr += "<option selected=\"1\" value=\"" + cat.catId + "\">" + cat.catLabel + "</option>\n";
           }
           else
           {
             catOptionsStr += "<option value=\"" + cat.catId + "\">" + cat.catLabel + "</option>\n";
           } // if (i == 0)..
         } // for (int i=0; i < catList.size(); i++)..
      }
      else
      {
         System.out.println(" **** catList IS null");
      } // if (catList != null)..
   } // if (grpCatId != 0 && catId == 0)..  
%>    
<jsp:include page="../Header.jsp?folderLevelDown=1"/>

    <table WIDTH=95%>
       <tr class="chapterHeader"><td>&nbsp;One-stop site that connects Credit Card Issuers, Retail Businesses and Individuals!</td></TR>
    </TABLE>
    <br>
     
    <table WIDTH=95%>
       <tr class="sectionHeader"><td>&nbsp;Register free at Rewards2Connect.com</td></TR>
    </TABLE>
    <br>

    <table WIDTH=95%>
       <tr><td>&nbsp;Welcome to the Rewards2Connect.com community!&nbsp;&nbsp;Please complete this free registration to start connecting..<br>&nbsp;(Note: * means "Required" field)<br><br></td></TR>
    </TABLE>
    
    <form onSubmit="return validate()" name="mainForm" method="POST" action="ProcessSignUp.jsp">
       <INPUT name="GRP_CAT_ID" type="hidden"/>
       <!-- <INPUT name="CAT_ID" type="hidden"/> -->
       
       <TABLE border=0 WIDTH=80%>
       <tr><td>
       
       <table width="100%" cellpadding="6" cellspacing="8" border="1">
       
          <%
              String errMsg = "";
              String error = request.getParameter("error");

              if (error != null)
              {
                 System.out.println(" **** error (NOT null): " + error);

                 if (error.equals("emailInvalid"))
                 {
                    errMsg = "Please enter a valid email address.";
                 }
                 else if (error.equals("errorEmailAlreadyRegistered"))
                 {
                    errMsg = "This email address is already registered at Rewards2Connect.com.\nPlease retry with a different email or click on Forgot Password link on Login page.";
                 }

                 if (!errMsg.equals(""))
                 {
             %>
                    <tr>
                        <td class="redM1" colspan=5><%= errMsg %><img src="../images/spacer.gif" height="8" style="display:block"></td>
                    <tr>          
             <%
                 } // if (!errMsg.equals(""))..
              }
              else
              {
                 System.out.println(" **** error is NULL ");
              }
          %>
         
          <tr class="sectionHeader5">
             <TD width=15% style="white-space:nowrap;">Group Category*<img src="../images/spacer.gif" height="2" style="display:block"></td>
             <TD width=25%>
                 <select id="group_cat" name="GRP_CATEGORY_DD" class="Arial10Text" size="1" onChange="changeGRPCAT(this.options[this.selectedIndex].value);">
                   <%= grpCatOptionsStr  %>
                 </select>
             </td>
             <td colspan=2>&nbsp;</td>
          </tr>
       <%
          if (grpCatId !=3100)
          {
       %>
             <tr class="sectionHeader6">
                <TD width=15% style="white-space:nowrap;" id='business_cat_label'>Sub Category*<img src="../images/spacer.gif" height="8"></td>
                <TD id='business_cat_dropdown'>
                    <select id="category" name="CATEGORY_DD" class="Arial10Text" size="1">
                      <%= catOptionsStr  %>
                    </select>
                </td>
                <td colspan=2><img src="../images/spacer.gif" height="4" style="display:block"></td>
             </tr>

             <tr class="sectionHeader5" id='business'>
                <TD width=15%style="white-space:nowrap;">Business Name*<img src="../images/spacer.gif" height="4" style="display:block"></td>
                <TD width=25%><input type="text" name="BUSINESS_NAME" class="txtfld" value="" size="25" maxlength="40"/></td>
                
                <TD width=15%>Business URL*<img src="../images/spacer.gif" height="4" style="display:block"></td>
                <TD><input type="text" name="BUSINESS_URL" class="txtfld" value="" size="35" maxlength="60"/></td>
             </tr>
            
             <tr class="sectionHeader6" id='business_addr1'>
                  <TD>Address Line 1<img src="../images/spacer.gif" height="8" style="display:block"></td>
                  <TD colspan=3><input type="text" name="ADDR_LINE1" class="txtfld" value="" size="25" maxlength="100"/></td>
             </tr>

             <tr class="sectionHeader5" id='business_addr2'>
                  <TD>Address Line 2<img src="../images/spacer.gif" height="8" style="display:block"></td>
                  <TD colspan=3><input type="text" name="ADDR_LINE2" class="txtfld" value="" size="25" maxlength="100"/></td>
             </tr>

             <tr class="sectionHeader6" id='business_addr3'>
                  <TD>Address Line 3<img src="../images/spacer.gif" height="8" style="display:block"></td>
                  <TD colspan=3><input type="text" name="ADDR_LINE3" class="txtfld" value="" size="25" maxlength="100"/></td>
             </tr>

             <tr class="sectionHeader5" id='business_city_st_zip'>
                  <TD style="white-space:nowrap;">City or Town<img src="../images/spacer.gif" height="8" style="display:block"></td>
                  <TD><input type="text" name="CITY" class="txtfld" value="" size="15" maxlength="40"/></td>
                  
                  <TD style="white-space:nowrap;">State or Province</td>
                  <td>
                     <table width="60%" cellpadding="6" cellspacing="8" border="0">
                        <tr>
                           <TD><input type="text" name="STATE" class="txtfld" value="" size="10" maxlength="30"/>&nbsp;&nbsp;</td>
                        </tr>
                     </table>
                  </td>
             </tr>
       <%
          }
       %>
             <tr class="sectionHeader6">
                  <TD style="white-space:nowrap;">Zip/PIN Code</td>
                  <TD><input type="text" name="ZIP" class="txtfld" value="" size="10" maxlength="30"/></td>
                  <TD style="white-space:nowrap;">Country&nbsp;*<img src="../images/spacer.gif" height="8" style="display:block"></td>
                  
                  <td>
                      <select id="country_list" name="COUNTRY" class="Arial10Text" size="1">
                          <%= countryOptionStr %>
                      </select>
                  </td>

                  <script>
                    // Get the select element by its ID
                    const selectElement = document.getElementById("country_list");

                    // Add an event listener for the 'change' event
                    selectElement.addEventListener('change', (event) => {
                       // Access the newly selected value via event.target.value
                       // You can call other functions or perform actions here
                       changePhoneCtryCode(event.target.value.slice(0, 2));
                    });
                    
                    const countryPhoneCodes = {
                       <%= NavUtils.getCountryCodePhoneCodeList() %>
                    };
                    
                    function getPhoneCode(isoCode)
                    {
                        // Ensure the input is uppercase for consistency
                        const code = isoCode.toUpperCase();
                        return countryPhoneCodes[code] || "Code not found";
                    }

                    function changePhoneCtryCode(countryCode)
                    {
                       ph_nbr_ctry_code_elem = document.getElementById("ph_nbr_country_code");
                       ph_nbr_ctry_code_elem.value = "+" + getPhoneCode(countryCode);
                    }
                  </script>
             </tr>
       <%
          if (grpCatId !=3100)
          {
       %>
               <tr class="sectionHeader5" id='business_email_phone'>
                  <TD style="white-space:nowrap;">Business e-mail:<img src="../images/spacer.gif" height="8" style="display:block"></td>
                  <td><input type="text" name="EMAILADDR" class="txtfld" value="" size="25" maxlength="80"/></td>
                  
                  <TD style="white-space:nowrap;">Business Phone Nbr:&nbsp;</td>
                  <td>
                     <table width="50%" cellpadding="2" cellspacing="2" border="1">
                        <tr>
                           <TD width=20%>Ctry_code</td>
                           <TD><input id="ph_nbr_country_code" type="text" name="PHONE_NBR_CTRY_CODE" value="+1" class="txtfld" size="2" maxlength="4"/></td>
                           <TD>&nbsp;Number&nbsp;</td>
                           <TD><input type="text" name="PHONE_NBR" class="txtfld" value="" size="15" maxlength="20"/></td>
                        </tr>
                     </table>
                  </td>
               </tr>
       <%
          }
          else
          {
       %>
          <tr class="sectionHeader5" id='individual_email_phone'>
             <TD style="white-space:nowrap;">E-mail address:<img src="../images/spacer.gif" height="8" style="display:block"></td>
             <td><input type="text" name="EMAILADDR" class="txtfld" value="" size="25" maxlength="80"/></td>
             <TD style="white-space:nowrap;">Phone Nbr:&nbsp;</td>
             <td>
                <table width="50%" cellpadding="2" cellspacing="2" border="1">
                   <tr>
                      <TD width=20%>Ctry_code</td>
                      <TD><input id="ph_nbr_country_code" type="text" name="PHONE_NBR_CTRY_CODE" value="+1" class="txtfld" size="2" maxlength="4"/></td>
                      <TD>&nbsp;Number&nbsp;</td>
                      <TD><input type="text" name="PHONE_NBR" class="txtfld" value="" size="15" maxlength="20"/></td>
                   </tr>
                </table>
             </td>
          </tr>
       <%
          }
       %>
          <tr><td colspan=4><hr><img src="../images/spacer.gif" height="4" style="display:block"></td></tr>
       
          <tr class="sectionHeader6">
             <TD width=15%>Username&nbsp;*<BR>(3 to 20 char.)<img src="../images/spacer.gif" height="8" style="display:block"></td>
             <TD width=25%><input type="text" name="USERNAME" class="txtfld" value="" size="15" maxlength="20" required="true"/></td>
             
             <td width=15%>&nbsp;</td>
             <td>&nbsp;</td>
          </tr>

          <tr class="sectionHeader5">
               <TD>Password&nbsp;*<img src="../images/spacer.gif" height="8" style="display:block"></td>
               <td><input type="password" name="PASSWORD" class="txtfld" value="" size="15" maxlength="20" required="true"/></td>
               
               <TD style="white-space:nowrap;">Confirm password&nbsp;*</td>
               <td><input type="password" name="PASSWORDCONF" class="txtfld" value="" size="15" maxlength="20" required="true"/></td>
          </tr>

          <tr class="sectionHeader6">
               <TD>First Name&nbsp;<img src="../images/spacer.gif" height="8" style="display:block"></td>
               <TD><input type="text" name="FIRSTNAME" class="txtfld" value="" size="20" maxlength="40"/></td>
               
               <TD>Last Name&nbsp;</td>
               <td><input type="text" name="LASTNAME" class="txtfld" value="" size="20" maxlength="40"/></td>
          </tr>

       </table>
       <hr>
       <img src="../images/spacer.gif" height="8" style="display:block">
       <table width="80%" cellpadding="1" cellspacing="8" border="1">
           <TR><HR></TR>
           <tr class="sectionHeader5">
               <td style="text-align: center;">
                   <input type="submit" value="Submit">
               </td>
           </tr>
       </table>
       
       </td></tr>
       </table>
    </form>

<script language="javascript">
function validate()
{
   if (document.mainForm.EMAILADDR.value.trim() === "" && document.mainForm.PHONE_NBR.value.trim() === "")
   {
      alert("MUST enter either Email address or phone number or both.");
      return false;
   }
   
   if (document.mainForm.GRP_CATEGORY_DD.value != "3100" &&
      (document.mainForm.BUSINESS_NAME.value.trim() === "" ||
      document.mainForm.BUSINESS_URL.value.trim() === ""))
   {
     alert("MUST enter both Business name and URL for a business account.");
     return false;  
   }
   return true;
}

function changeGRPCAT(grpCatId)
{
   document.mainForm.GRP_CAT_ID.value = grpCatId;
   document.mainForm.action = "Register.jsp";
   document.mainForm.submit();
} // function changeGRPCAT(grpCatId)..

function changeCAT(catId)
{
   document.mainForm.CAT_ID.value = catId;
}
</script>

<table width="95%" cellpadding="1" cellspacing="8" border="0">
   <TR><HR><img src="../images/spacer.gif" height="8" style="display:block"></TR>
   <tr class="sectionHeader6">
     <td>
      <!--<span class="urs_legal v1">-->
          By clicking the "Submit" button, you agree to Rewards2Connect.com's <a href="../tandc/Terms.jsp">Terms and Conditions</a> and have read and understand our <a href="../tandc/Privacy.jsp">Privacy Policy</a>. &nbsp; In compliance with the <a class="urs_b" href="http://www.ftc.gov/ogc/coppa1.htm">Children's Online Privacy Protection Act of 1998</a>, Rewards2Connect.com does not accept membership registrations from users who are under 13 years of age. &nbsp;By registering with Rewards2Connect.com, you affirm that you are at least 13 years old.
      <!--</span>-->
     </td>
   </tr>
</table>
<jsp:include page="../Footer.jsp?folderLevelDown=1"/>
