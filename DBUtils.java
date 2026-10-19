package shared;

import java.sql.*;
import java.text.*;
import java.util.*;

public class DBUtils
{
   static Connection connection = null;
   static boolean isLocal = true;

   public static Connection getConnection()
   {    
       try
       {
           // if (connection == null || schedulerCall)
           if (connection == null || connection.isClosed())
           {
              System.out.println(" **** DBUtils:getConnection(): connection is NULL or closed");

              String DB_URL;
              String DB_USER;
              String DB_PSSWD;

              try
              {
                 Class.forName("com.mysql.cj.jdbc.Driver");
                 if (isLocal)
                 {
                    DB_URL = "jdbc:mysql://localhost:3306/rewards2connectdb";
                    DB_USER = "root";
                    DB_PSSWD = "";
                 }
                 else
                 {
                    DB_URL = "jdbc:mysql://localhost:3306/unetlink_rewards2connectdb";
                    DB_USER = "unetlink_rewards2connectdb_admin";
                    DB_PSSWD = "StPeters12?";
                 }

                 Properties props = new Properties();
                 props.setProperty("user", DB_USER);
                 props.setProperty("password", DB_PSSWD);
                 // props.setProperty("autoReconnect", "true");

                 connection = DriverManager.getConnection(DB_URL, props);

                 if (connection == null)
                     System.out.println(" **** DBUtils:getConnection(): returning connection is NULL");
                 else
                     System.out.println(" **** DBUtils:getConnection(): returning connection is NOT NULL");

                 //lastConnectionTime = LocalDateTime.now();
                 //Duration duration = Duration.ofSeconds(wait_timeout-3600);

                 //reconnectDateTime = lastConnectionTime.plus(duration);
              }
              catch (ClassNotFoundException c)
              {
                 System.out.println(" **** DBUtils: ClassNotFoundException: " + c.getMessage());
              }
              catch (SQLException s)
              {
                 System.out.println(" **** DBUtils: SQLException: " + s.getMessage());
              }
           }
       }
       catch (SQLException s)
       {
           System.out.println("**** Caught SQLException in DBUtils::getConnection() when calling isClosed(): msg: " + s.getMessage());
       }

       return connection;
   }

   public static void closeConnection()
   {
      try
      {
         // 1. Clear MySQL Connection Cleanup Thread (Very common)
         try {
           Class<?> mysqlCleanup = Class.forName("com.mysql.cj.jdbc.AbandonedConnectionCleanupThread");
           mysqlCleanup.getMethod("checkedShutdown").invoke(null);
         } catch (Throwable e) {
           // Fallback for older MySQL drivers
           try { Class.forName("com.mysql.jdbc.AbandonedConnectionCleanupThread").getMethod("shutdown").invoke(null); } catch (Throwable t) {}
         }

         // Close the JDBC connection
         if (connection != null && !connection.isClosed())
         {
            connection.close();
            connection = null;
         }

         // De-register the JDBC Driver (to prevent memory leak)
         Driver driver = null, d = null;
         Enumeration<Driver> drv = DriverManager.getDrivers();

         while (drv.hasMoreElements())
         {
            d = drv.nextElement();

            if (d.getClass().getName().equals("com.mysql.cj.jdbc.Driver"))
            {
               driver = d;
               break;
            }
         }

         if (driver != null)
         {
            DriverManager.deregisterDriver(driver);
            System.out.println("MySQL JDBC driver unregistered successfully.");
         }
         else
         {
            System.out.println("MySQL JDBC driver not found in DriverManager.");
         }
      }
      catch (SQLException e)
      {
         System.err.println("DBUtils::closeConnection(): SQLException unregistering driver: " + e.getMessage());
         e.printStackTrace();
      }
   }

   public static int getWaitTimeout()
   {
      int wait_timeout = 28800;
      String getWaitTimeout = "SHOW VARIABLES LIKE 'wait_timeout';";
      if (connection == null)
      {
         connection = getConnection();
      }
      ResultSet rs = null;

      try
      {
         Statement statement = connection.createStatement();
         rs = statement.executeQuery(getWaitTimeout);        

         while (rs.next())
         {
            wait_timeout = rs.getInt("wait_timeout");
         }
      }
      catch (Exception e)
      {
         System.out.println(" **** DBUtils::getWaitTimeout() exception: " + e.getMessage());
      }
      return wait_timeout;
   }

   public static HashMap<Integer,GroupCategoryType> getNbrGroupCatHMByType()
   {
      if (connection == null)
      {
         System.out.println(" **** DBUtils:getGroupCatList(): connection is NULL, so will call getConnection()");
         connection = getConnection();
      }
     
      HashMap<Integer,GroupCategoryType> nbrGroupCatHMByType = new HashMap<Integer,GroupCategoryType>();
     
      String sqlSelectGroupCatByType = "select gc.group_cat_type_id, gcl.group_cat_type_desc, count(*)" +
                                       " as nbr_groups_by_type from group_category gc, group_cat_type_lookup gcl " +
                                       "where gc.group_cat_type_id = gcl.group_cat_type_id group by group_cat_type_id";
      int grpCatType = 0;
      int nbrGrpCatType = 0;
      ResultSet rs = null;
      GroupCategoryType gct = null;

      try
      {
         Statement statement = connection.createStatement();
         rs = statement.executeQuery(sqlSelectGroupCatByType);        

         while (rs.next())
         {
            gct = new GroupCategoryType();
            gct.grpCatTypeId = rs.getInt("group_cat_type_id");
            gct.nbrGrpCatType = rs.getInt("nbr_groups_by_type");
            gct.grpCatTypeDesc = rs.getString("group_cat_type_desc");

            nbrGroupCatHMByType.put(gct.grpCatTypeId, gct);
         }
      }
      catch (Exception e)
      {
         System.out.println(" **** DBUtils::getNbrGroupCatHMByType(): Caught exception: " + e.getMessage());
      }

      return nbrGroupCatHMByType;    
   }

   public static List<GroupCategory> getGroupCatList()
   {
      if (connection == null)
      {
         System.out.println(" **** DBUtils:getGroupCatList(): connection is NULL, so will call getConnection()");
         connection = getConnection();
      }

      ResultSet rs = null;
      String sqlSelectGroupCat = "select * from group_category order by group_cat_type_id, display_order";

      GroupCategory grpCat = new GroupCategory();
      List<GroupCategory> grpCatList = new ArrayList<GroupCategory>();
      List<Category> catList = null;

      try
      {
          Statement statement = connection.createStatement();
          rs = statement.executeQuery(sqlSelectGroupCat);        

          while (rs.next())
          {
              grpCat = new GroupCategory();

              grpCat.grpPageHeader = rs.getString("group_page_header");
              grpCat.grpPageDesc = rs.getString("group_page_desc");

              grpCat.grpCatId = rs.getInt("group_cat_id");
              grpCat.grpCatName = rs.getString("group_cat_name");
              grpCat.grpCatLabel = rs.getString("group_cat_label");
              grpCat.grpCatDesc = rs.getString("group_cat_desc");
             
              grpCat.grpCatTypeId = rs.getInt("group_cat_type_id");

              grpCat.catList = getCatListbyGroupCatId(grpCat.grpCatId);

              grpCatList.add(grpCat);
          }
      }
      catch (Exception e)
      {
         System.out.println(" **** DBUtils::getGroupCatList(): Caught exception: " + e.getMessage());
      }

      return grpCatList;
   }

   public static List<Category> getCatList()
   {
       if (connection == null)
       {
          connection = getConnection();
       }

       ResultSet rs = null;
       String sqlSelectCat = "select * from category order by display_order";
       
       Category cat = new Category();
       List<Category> catList = new ArrayList<Category>();

       try
       {
           Statement statement = connection.createStatement();
           rs = statement.executeQuery(sqlSelectCat);        

           while (rs.next())
           {
               cat = new Category();
               cat.catId = rs.getInt("cat_id");
               cat.catLabel = rs.getString("cat_label");
               cat.catDesc = rs.getString("cat_desc");
               catList.add(cat);
           }

           // return catList;
       }
       catch (Exception e)
       {
           System.out.println(" **** DBUtils::getCatList(): Caught exception: " + e.getMessage());
       }

       return catList;
   }

   public static List<Category> getCatListbyGroupCatId(int grpCatId)
   {
       if (connection == null)
       {
          connection = getConnection();
       }

       ResultSet rs = null;
       String sqlSelectCat = "select * from group_category gc, category c where gc.group_cat_id = c.group_cat_id and c.group_cat_id = " + grpCatId + " order by c.display_order";

       Category cat = new Category();
       List<Category> catList = new ArrayList<Category>();

       try
       {
           Statement statement = connection.createStatement();
           rs = statement.executeQuery(sqlSelectCat);        

           while (rs.next())
           {
               cat = new Category();

               cat.grpCatId = rs.getInt("group_cat_id");
               cat.grpPageHeader = rs.getString("group_page_header");
               cat.grpPageDesc = rs.getString("group_page_desc");
               cat.grpCatLabel = rs.getString("group_cat_label");

               cat.pageHeader = rs.getString("page_header");
               cat.pageDesc = rs.getString("page_desc");
               
               cat.catId = rs.getInt("cat_id");
               cat.catName = rs.getString("cat_name");
               cat.catLabel = rs.getString("cat_label");
               cat.catDesc = rs.getString("cat_desc");
               catList.add(cat);
           }

           // return catList;
       }
       catch (Exception e)
       {
           System.out.println(" **** DBUtils::getCatListbyGroupCatId(): Caught exception: " + e.getMessage());
       }

       return catList;
   }
}
