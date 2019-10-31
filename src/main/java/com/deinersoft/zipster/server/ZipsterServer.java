package main.java.com.deinersoft.zipster.server;

import main.java.com.deinersoft.zipster.core.Zipster;
import org.json.JSONObject;

import static spark.Spark.*;


public class ZipsterServer {

    public static void main(String[] args) {

        port(9002);
        post("/checkWordster", (request, response) -> {
            if (request.body().equals("STOP")) stop();
            JSONObject obj = new JSONObject(request.body());
            String numberInDigits = obj.getString("numberInDigits");
            response.type("text/json");
            return "{\"numberInDigits\": " + "\"" + numberInDigits + "\", " +
                    "\"numberInWords\": \"" + new Zipster(numberInDigits).getWords() + "\"}";
        });
    }
}