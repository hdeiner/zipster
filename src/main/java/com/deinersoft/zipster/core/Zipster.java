package main.java.com.deinersoft.zipster.core;

import org.json.JSONObject;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.TimeZone;

public class Zipster {

    private String zipcode;
    private String radius;
    private final String METERS_TO_MILES = "0.000621371192";

    public Zipster(String zipcode, String radius) throws ZipsterException {
        this.zipcode = zipcode;
        this.radius = radius;
    }

    public JSONObject getPostOfficesWithinRadius() {

        JSONObject resultSet = new JSONObject();
        resultSet.put("radius", radius);
        resultSet.put("zipcode", zipcode);

        try {
//                InputStream inputStream = new FileInputStream("/usr/local/tomcat/webapps/passwordAPI_properties/oracleConfig.properties");
//                Properties properties = new Properties();
//                properties.load(inputStream);
//                String url = properties.getProperty("url");
//                String user = properties.getProperty("user");
//                String password = properties.getProperty("password");
            String url = "jdbc:mysql://localhost:3306/zipster?useSSL=false";
            String user = "root";
            String password = "password";

            TimeZone timeZone = TimeZone.getTimeZone("America/New_York");
            TimeZone.setDefault(timeZone);
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            Connection conn = DriverManager.getConnection(url,user,password);
            Statement stmt = conn.createStatement();
            ResultSet rs;

            String query =
                    "SELECT T1.*, st_distance_sphere(point(T1.LONGITUDE, T1.LATITUDE), T2.COORDS) * " + METERS_TO_MILES + " AS DISTANCE\n" +
                    "FROM zipster.ZIPCODES AS T1, zipster.ZIPCODES AS T2 \n" +
                    "WHERE st_distance_sphere(point(T1.LONGITUDE, T1.LATITUDE), T2.COORDS) <= " + radius + "/" + METERS_TO_MILES + "\n" +
                    "AND T2.ZIPCODE = " + zipcode + "\n" +
                    "AND T1.ZIPCODE != " + zipcode + "\n" +
                    "ORDER BY st_distance_sphere(point(T1.LONGITUDE, T1.LATITUDE), T2.COORDS) * " + METERS_TO_MILES + " ASC\n";

            rs = stmt.executeQuery(query);
            while ( rs.next() ) {
                JSONObject row = new JSONObject();
                row.put("zipcode", rs.getString("ZIPCODE"));
                row.put("zipcode_type", rs.getString("ZIPCODE_TYPE"));
                row.put("city", rs.getString("CITY"));
                row.put("state", rs.getString("STATE"));
                row.put("location_type", rs.getString("LOCATION_TYPE"));
                row.put("latitude", rs.getString("LATITUDE"));
                row.put("longitude", rs.getString("LONGITUDE"));
                row.put("location", rs.getString("LOCATION"));
                row.put("decomissioned", rs.getString("DECOMISSIONED"));
                row.put("distance", rs.getString("DISTANCE"));
                resultSet.append("results", row);
            }
            conn.close();
        } catch (Exception e) {
            resultSet.put("Got an exception!", e.getMessage());
        }

        return resultSet;

    }
}