package main.java.com.deinersoft.zipster.core;

import org.apache.commons.io.IOUtils;
import org.json.JSONObject;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.TimeZone;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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

        String environment = "";
        String vault_addr = "";
        String vault_token = "";
        try {
            environment = new String(Files.readAllBytes(Paths.get("/tmp/config/zipster/environment"))).trim();
            vault_addr = new String(Files.readAllBytes(Paths.get("/tmp/config/zipster/vault_addr"))).trim();
            vault_token = new String(Files.readAllBytes(Paths.get("/tmp/config/zipster/vault_token"))).trim();
        } catch (Exception e) {
            environment = "DESKTOP";
            vault_addr = "localhost";
            try {
                vault_token = new String(Files.readAllBytes(Paths.get("./.vault_root_token")));
            } catch (Exception ex) {
                resultSet.put("Could not read ./.vault_root_token", e.getMessage());
            }
        }

        String dbURL = "jdbc:mysql://mysql:3306/zipster?useSSL=false";
        String dbUSER = "root";
        String dbPASSWORD = "password";
        try {
            if (!environment.equals("")) {
                String shellCommand = "vault login -address=\"http://" + vault_addr +":8200\" -format=json " + vault_token;
                ProcessBuilder pbVaultLogin = new ProcessBuilder("bash", "-c", shellCommand);
                String pbVaultLoginOutput = IOUtils.toString(pbVaultLogin.start().getInputStream());

                shellCommand = "vault kv get -address=\"http://" + vault_addr + ":8200\" -format=json  ENVIRONMENTS/" + environment + "/MYSQL";
                ProcessBuilder pbVaultKvGet = new ProcessBuilder("bash", "-c", shellCommand);
                String pbVaultKvGetOutput = IOUtils.toString(pbVaultKvGet.start().getInputStream());

                String sPatternUrl = "(\\\"url\\\"\\:)\\W*\\\"(.*)\\\"";
                Pattern patternUrl = Pattern.compile(sPatternUrl);
                Matcher matcherUrl = patternUrl.matcher(pbVaultKvGetOutput);
                matcherUrl.find();
                dbURL = matcherUrl.group(2);

                String sPatternUser = "(\\\"user\\\"\\:)\\W*\\\"(.*)\\\"";
                Pattern patternUser = Pattern.compile(sPatternUser);
                Matcher matcherUser = patternUser.matcher(pbVaultKvGetOutput);
                matcherUser.find();
                dbUSER = matcherUser.group(2);

                String sPatternPassword = "(\\\"password\\\"\\:)\\W*\\\"(.*)\\\"";
                Pattern patternPassword = Pattern.compile(sPatternPassword);
                Matcher matcherPassword = patternPassword.matcher(pbVaultKvGetOutput);
                matcherPassword.find();
                dbPASSWORD = matcherPassword.group(2);
            }
        } catch (Exception e) {
            resultSet.put("Got an exception!", e.getMessage());
        }

        try {
            TimeZone timeZone = TimeZone.getTimeZone("America/New_York");
            TimeZone.setDefault(timeZone);
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            Connection conn = DriverManager.getConnection(dbURL,dbUSER,dbPASSWORD);
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