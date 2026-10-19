<!-- Begin: GenerateCoupon.jsp -->
<%@ page import="java.sql.*, shared.*, java.util.*, java.text.*, java.time.*, java.time.format.*" %>
<%
   System.out.println(" **** in Generate Coupon");
   
   int userId = 0;
   
   Integer intUserId = (Integer)session.getAttribute("USERID");

   if (intUserId != null)
   {
      userId = intUserId.intValue();
   }
   
   System.out.println(" **** userId: " + userId);
   
   int businessId = 0;
   String strBusinessId = request.getParameter("business_id");
   
   if (strBusinessId != null)
   {
      businessId = Integer.parseInt(strBusinessId);
   }
   
   System.out.println(" **** businessId: " + businessId);
   
   if (userId != 0 && businessId != 0)
   {
      String upcBarcode = UpcBarcodeGenerator.generateRandomUpcA(userId, businessId);
     
      System.out.println(" ******************************************** ");
      System.out.println(" ***** Generate Coupon: ");
      System.out.println(" **** userId: " + userId + ", businessId: " + businessId);

      System.out.println("Generated UPC-A Barcode: " + upcBarcode);  
     
      LocalDateTime now = LocalDateTime.now();
      // Create a Duration equal to 180 days (as 24-hour chunks)
      Duration duration = Duration.ofDays(180);
      LocalDateTime expDateTime = now.plus(duration);

      DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
      String expDate = expDateTime.format(formatter);

      Statement statement = null;
      ResultSet rs = null;
   
      Connection connection = DBUtils.getConnection();
     
      statement = connection.createStatement();

      String sqlInsertCheckoutDiscount = "insert into checkout_discount (user_id, business_id, checkout_discount_str, date_generated, date_of_expiration, is_enabled)"
                                         + " values (" + userId + "," + businessId + "," + upcBarcode + ",CURRENT_TIMESTAMP,'" + expDate + "',1)";

      System.out.println(" insert checkout discount = " + sqlInsertCheckoutDiscount);
      statement.executeUpdate(sqlInsertCheckoutDiscount);

      response.sendRedirect("ListParticipants.jsp?type=2");
   }
   else response.sendRedirect("ListParticipants.jsp?type=2&state=upcBarcodeError");

   // response.sendRedirect("ListParticipants.jsp?type=2&upc_barcode=" + upcBarcode + "&business_id_for_upc_barcode=" + businessId);
%>
<!-- End: GenerateCoupon.jsp -->
