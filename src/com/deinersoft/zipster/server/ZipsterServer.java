package com.deinersoft.zipster.server;

import com.deinersoft.zipster.core.Zipster;
import com.googlecode.totallylazy.Zip;
import org.json.JSONObject;

import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Properties;
import java.util.TimeZone;

import static spark.Spark.*;


public class ZipsterServer {

    public static void main(String[] args) {

        port(9002);
        post("/zipster", (request, response) -> {
            if (request.body().equals("STOP")) stop();
            JSONObject jsonObject = new JSONObject(request.body());

            Zipster zipster = new Zipster(jsonObject.getString("zipcode"), jsonObject.getString("radius"));
            JSONObject resultSet = zipster.getPostOfficesWithinRadius();

            response.type("text/json");
            return resultSet.toString(4);
        });
    }
}