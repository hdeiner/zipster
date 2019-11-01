package test.java.com.deinersoft.zipster.client;

import us.monoid.json.JSONArray;
import us.monoid.json.JSONObject;
import us.monoid.web.JSONResource;
import us.monoid.web.Resty;

import java.net.URI;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;

import static us.monoid.web.Resty.content;

public class ZipsterClient {
    private String whichServer;

    public ZipsterClient(String whichServer) throws Exception {
        this.whichServer = whichServer;
    }

    public void startServer() throws Exception {
        if (whichServer.equals("WireMock")) {
        }

        if (whichServer.equals("Local")) {
        }

        if (whichServer.equals("AWS")) {
        }

    }

    public void stopServer() throws Exception {
        if (whichServer.equals("WireMock")) {
        }

        if (whichServer.equals("Local")) {
        }

        if (whichServer.equals("AWS")) {
        }
    }

    public JSONArray getPostOfficesWithinRadius(String zipcode, String radius) throws Exception {
        Resty resty  = new Resty();

        URL url = null;
        URI uri;

        if (whichServer.equals("WireMock")) url = new URL("http://0.0.0.0:9001/zipster");

        if (whichServer.equals("Local")) url = new URL("http://0.0.0.0:9002/zipster");

        if (whichServer.equals("AWS")) {
            String zipster_dns = new String(Files.readAllBytes(Paths.get(".zipster_dns")));
            url = new URL("http://" + zipster_dns.trim() + "/zipster");
        }

        uri = new URI(url.getProtocol(), url.getUserInfo(), url.getHost(), url.getPort(), url.getPath(), url.getQuery(), url.getRef());
        String requestToPost = "{\"zipcode\": \"" + zipcode + "\", \"radius\": \"" + radius + "\"}";

        JSONResource response = resty.json(uri,content(new JSONObject(requestToPost)));
        JSONArray results = (JSONArray) response.get("results");

        return results;
    }

}