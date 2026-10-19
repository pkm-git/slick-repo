<jsp:include page="../Header.jsp?folderLevelDown=1"/>
<%@ page import="java.sql.*, shared.*, java.util.*, java.io.IOException, java.awt.image.BufferedImage, javax.imageio.ImageIO, java.awt.*, com.google.zxing.BarcodeFormat, com.google.zxing.MultiFormatWriter, com.google.zxing.client.j2se.MatrixToImageWriter, com.google.zxing.common.BitMatrix, com.google.zxing.oned.UPCAWriter, java.nio.file.Path, java.nio.file.Paths" %>
<%
   Statement statement = null;
   Statement statement2 = null;
   ResultSet rs = null;
   ResultSet rs2 = null;
   
   Connection connection = DBUtils.getConnection();
   statement = connection.createStatement();
   statement2 = connection.createStatement();

   System.out.println("*************** in List My Stores jsp ");
   
   int userId = 0;
   int type = 0;

   Integer intUserId = (Integer)session.getAttribute("USERID");

   java.util.List businessList = new ArrayList();
   Business business;

   String strBusinessType = "";

   if (intUserId != null)
   {
      System.out.println("*********** user id in session = " + intUserId);
      userId = intUserId.intValue();

      String sqlSelectCheckoutDiscount = "";

      String strType = request.getParameter("type");
      if (strType != null && !strType.equals(""))
      {
         type = Integer.parseInt(strType);
         
         if (type == 1) strBusinessType = "Credit Card Issuers";
         else if (type == 2) strBusinessType = "Services/Retail Stores/Restaurants";

         // String strUpcBarcode = request.getParameter("upc_barcode");
         
         // String strBusinessIdForUpcBarcode = request.getParameter("business_id_for_upc_barcode");
         
         //int businessIdForUpcBarcode = 0;
         //if (strBusinessIdForUpcBarcode != null)
         //{
           // businessIdForUpcBarcode = Integer.parseInt(strBusinessIdForUpcBarcode);
         //}
         
         // String sqlSelectBusiness = "select * from business b, group_category gc, category c, checkout_discount cd where b.group_cat_id = gc.group_cat_id and b.cat_id = c.cat_id and c.group_cat_id = gc.group_cat_id and cd.user_id = " + userId + " and cd.business_id=b.business_id and gc.group_cat_type_id=" + strType;
         // String sqlSelectBusiness = "select * from business b, group_category gc, category c LEFT JOIN checkout_discount cd on cd.business_id=business_id where b.group_cat_id = gc.group_cat_id and b.cat_id = c.cat_id and c.group_cat_id = gc.group_cat_id and cd.user_id = " + userId + " and gc.group_cat_type_id=" + strType;
         String sqlSelectBusiness = "select * from business b, group_category gc, category c where b.group_cat_id = gc.group_cat_id and b.cat_id = c.cat_id and c.group_cat_id = gc.group_cat_id and b.is_HQ=1 and b.is_active=1 and gc.group_cat_type_id=" + strType;

         System.out.println(" **** sqlSelectBusiness: " + sqlSelectBusiness);

         rs = statement.executeQuery(sqlSelectBusiness);

         // System.out.println(" **** DONE: Select Query");

         boolean found = false;
         int is_HQ = 0;
         int is_active = 0;      
         
         int cnt = 0;
         /*
         while (rs.next())
         {
            cnt += 1;
         }
         */
         // System.out.println(" **** ---- rs.size: " + cnt + " ------------------- **** ");        

         // cnt = 0;

         while (rs.next())
         {
            cnt += 1;
           
            System.out.println(" **** cnt: " + cnt);

            is_HQ = rs.getInt("is_HQ");
            is_active = rs.getInt("is_active");

            if (is_HQ != 1 || is_active != 1)
            {
               continue;
            }

            business = new Business();

            business.businessId = rs.getInt("business_id");
            business.businessName = rs.getString("business_name");
           
            System.out.println(" **** businessName: " + business.businessName);

            business.businessURL = rs.getString("business_url");
            business.emailAddr = rs.getString("email_addr");
            business.phoneCountryCode = rs.getString("phone_country_code");
            business.phoneNbr = rs.getString("phone_nbr");
            business.countryName = rs.getString("country_name");

            business.addressLine1 = rs.getString("address1");      
            business.addressLine2 = rs.getString("address2");
            business.addressLine3 = rs.getString("address3");

            business.city = rs.getString("city");
            business.state = rs.getString("state");
            business.zip = rs.getString("zip_code");

            business.isHQ = is_HQ == 1? true:false;
            business.isActive = is_active == 1? true:false;

            business.grpCatId = rs.getInt("group_cat_id");
            business.catId = rs.getInt("cat_id");
   
            business.grpCatDesc = rs.getString("group_cat_desc");
            business.catDesc = rs.getString("cat_desc");
           
            sqlSelectCheckoutDiscount = "select * from checkout_discount cd where cd.business_id=" + business.businessId + " and cd.user_id = " + userId;
           
            System.out.println(" **** sqlSelectCheckoutDiscount: " + sqlSelectCheckoutDiscount);

            rs2 = statement2.executeQuery(sqlSelectCheckoutDiscount);
           
            while (rs2.next())
            {
               business.checkoutDiscountStr = rs2.getString("checkout_discount_str");
               break;
            }

            if (business.checkoutDiscountStr != null && !business.checkoutDiscountStr.equals(""))
            {
               int width = 245;
               int height = 120;
               
               int textHeight = 30; // Extra space for the numeric label

               try
               {
                  // 1. Generate BitMatrix
                  BitMatrix bitMatrix = new MultiFormatWriter().encode(
                      business.checkoutDiscountStr, BarcodeFormat.CODE_128, width, height
                  );

                  // 2. Convert BitMatrix to BufferedImage
                  BufferedImage barcodeImage = MatrixToImageWriter.toBufferedImage(bitMatrix);

                  // 3. Create a new BufferedImage with extra height for the text
                  BufferedImage combinedImage = new BufferedImage(
                      width, height + textHeight, BufferedImage.TYPE_INT_RGB
                  );

                  Graphics2D g2d = combinedImage.createGraphics();

                  // Set background to white
                  g2d.setColor(Color.WHITE);
                  g2d.fillRect(0, 0, width, height + textHeight);

                  // Draw the barcode image on top
                  g2d.drawImage(barcodeImage, 0, 0, null);

                  // Configure font and color for the numeric text
                  g2d.setColor(Color.BLACK);
                  g2d.setFont(new Font("SansSerif", Font.PLAIN, 14));
                  FontMetrics fontMetrics = g2d.getFontMetrics();

                  // Center the text horizontally below the barcode
                  int textWidth = fontMetrics.stringWidth(business.checkoutDiscountStr);
                  int x = (width - textWidth) / 2;
                  int y = height + fontMetrics.getAscent() + 2;

                  g2d.drawString(business.checkoutDiscountStr, x, y);
                  g2d.dispose();

                  // 4. Save the combined image to the target path
                  // Path path = FileSystems.getDefault().getPath("barcode_with_text.png");
                  
                  System.out.println("request.getContextPath(): " + request.getContextPath());

                  // Path path = Paths.get(request.getContextPath() + "/upc_barcodes/barcode_" + business.checkoutDiscountStr + ".png");
                  Path path = Paths.get(request.getContextPath() + "/upc_barcodes/barcode_" + business.checkoutDiscountStr + ".png");
                  ImageIO.write(combinedImage, "PNG", path.toFile());

                  System.out.println("Barcode with text generated successfully.");
               }
               catch (Exception e)
               {
                  e.printStackTrace();
               }
            }
                     
            System.out.println(" **** business.businessName: " + business.businessName + ", business.grpCatDesc: " + business.grpCatDesc + ", business.catDesc: " + business.catDesc);

            businessList.add(business);
         }
      }

      session.setAttribute("MYRETAILSTORELIST", businessList);
   }
%>
   <br>
   <table width="90%"  border="0"  cellspacing="6" cellpadding="6" align="center">
      <TR CLASS="JOLButtonInTDWithBorder">
         <td width="2%" valign="top"><img src="../images/spacer.gif" height="5" style="display:block"></td>
         <TD width="40%" style="white-space:nowrap;" CLASS="chapterHeader">&nbsp;Participating <%= strBusinessType %></TD>

         <td width="2%" valign="top">&nbsp;</td>

         <%
            if (type == 1)
            {
         %>
              <TD style="white-space:nowrap;"><img src="../images/spacer.gif" height="5" style="display:block"><a HREF="ListParticipants.jsp?type=2">Participating Stores/Restaurants</A></TD>
         <%
            }
            else
            {
         %>
              <TD style="white-space:nowrap;"><img src="../images/spacer.gif" height="5" style="display:block"><a HREF="ListParticipants.jsp?type=1">Participating Credit Card Issuers</A></TD>
         <%
            }
         %>

         <TD WIDTH=2%></TD>
         <TD style="white-space:nowrap;"><img src="../images/spacer.gif" height="5" style="display:block"><a HREF="ListMyReferrals.jsp">My Referrals</A></TD>

         <td width="2%" valign="top">&nbsp;</td>
         <TD style="white-space:nowrap;"><img src="../images/spacer.gif" height="6" style="display:block"><a HREF="ViewProfile.jsp">View Profile</A></TD>
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
                  <td class="blackBorder" width=90%>
             
                     <table width="100%" cellpadding="8" cellspacing="8" border="0" CLASS="DefaultTextWhiteBackground">
                        <tr class="sectionHeader">
                           <td>Group Category</td>
                           <td>Category</td>
                           <td>Business Name</td>
                           <td>Business URL</td>
                           <td align="center">Coupon Code</td>
                           <td align="center">Coupon Image</td>
                        </tr>
                        <%
                           String rowClass = "sectionHeader5";

                           if (businessList.size() == 0)
                           {
                        %>
                              <tr class="<%= rowClass %>"><td colspan=5>&nbsp;No participants yet. You will be informed as soon as there are participants..</td></tr>
                        <%
                           }
                           else
                           {
                              for (int i=0; i < businessList.size(); i++)
                              {
                                 business = (Business)businessList.get(i);
                                 System.out.println(" **** List My Businesses: i: " + i + ", business.businessName: " + business.businessName);
                        %>
                                 <tr class="<%= rowClass %>">
                                    <TD><%= business.grpCatDesc %></td>
                                    <TD><%= business.catDesc %></td>
                                    <TD><%= business.businessName %></td>
                                    <TD><%= business.businessURL %></td>
                                   
                                    <%
                                        if (business.checkoutDiscountStr != null && !business.checkoutDiscountStr.equals(""))
                                        {
                                    %>
                                           <TD>
                                              <%= business.checkoutDiscountStr %>
                                           </td>
                                           <td><img width="196px" height="120px" style="display:block;" src="<%= "../upc_barcodes/barcode_" + business.checkoutDiscountStr + ".png" %>">
                                    <%
                                        }
                                        else
                                        {
                                    %>
                                           <TD colspan=2>
                                              <form method="POST" action="GenerateCoupon.jsp">
                                                 <input type=hidden name=business_id value=<%= business.businessId %>>
                                                 <input type="image" name="submit" src="../images/gen_coupon.png"/>
                                                 <!-- <input type="image" name="submit" src="../images/generate_coupon.png"/> -->
                                              </form>
                                    <%
                                        }
                                    %>
                                    </td>
                                 </tr>
                        <%
                                 if (rowClass.equals("sectionHeader5"))
                                     rowClass = "sectionHeader6";
                                 else rowClass = "sectionHeader5";
                              } //for (int i=0; i < adList.size(); i++)..
                           } // if (businessList.size() == 0)..
                        %>

                     </table>
                     <hr>
                  </td>
               </tr>
            </table>
        </td>
     </tr>
  </table>
<jsp:include page="../Footer.jsp?folderLevelDown=1"/>
