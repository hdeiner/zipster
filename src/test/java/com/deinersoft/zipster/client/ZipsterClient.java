package test.java.com.deinersoft.zipster.client;

import org.apache.commons.io.IOUtils;
import us.monoid.json.JSONArray;
import us.monoid.json.JSONObject;
import us.monoid.web.JSONResource;
import us.monoid.web.Resty;

import java.net.URI;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static us.monoid.web.Resty.content;

public class ZipsterClient {
    private String whichServer;

    public ZipsterClient(String whichServer) throws Exception {
        this.whichServer = whichServer;
    }

    public JSONArray getPostOfficesWithinRadius(String zipcode, String radius) throws Exception {
        Resty resty  = new Resty();
        URL url = null;
        URI uri;

        String environment = "";
        String vault_addr = "";
        String vault_token = "";
        String serviceEnvironment = "";

        try {
            environment = new String(Files.readAllBytes(Paths.get("/tmp/config/zipster/environment"))).trim();
            vault_addr = new String(Files.readAllBytes(Paths.get("/tmp/config/zipster/vault_addr"))).trim();
            vault_token = new String(Files.readAllBytes(Paths.get("/tmp/config/zipster/vault_token"))).trim();
            if (!environment.equals("AWS_DEMO")) {
                vault_addr = "localhost";   // unhappily, this client runs outside of the docker environment unless in AWS environment!
            }
        } catch (Exception e) {
            throw e;
        }

//        System.out.println("ZipsterClient        environment="+environment);
//        System.out.println("ZipsterClient         vault_addr="+vault_addr);
//        System.out.println("ZipsterClient        vault_token="+vault_token);

        String shellCommand = "vault login -address=\"http://" + vault_addr +":8200\" -format=json " + vault_token;
//        System.out.println("ZipsterClient       shellCommand="+shellCommand);
        ProcessBuilder pbVaultLogin = new ProcessBuilder("bash", "-c", shellCommand);
        String pbVaultLoginOutput = IOUtils.toString(pbVaultLogin.start().getInputStream());

        if (whichServer.equals("WireMock")) serviceEnvironment = "WIREMOCK";
        if (whichServer.equals("Concrete")) serviceEnvironment = "ZIPSTER";

        shellCommand = "vault kv get -address=\"http://" + vault_addr + ":8200\" -format=json  ENVIRONMENTS/" + environment + "/" + serviceEnvironment;
//        System.out.println("ZipsterClient       shellCommand="+shellCommand);
        ProcessBuilder pbVaultKvGet = new ProcessBuilder("bash", "-c", shellCommand);
        String pbVaultKvGetOutput = IOUtils.toString(pbVaultKvGet.start().getInputStream());
//        System.out.println("ZipsterClient pbVaultKvGetOutput="+pbVaultKvGetOutput);

        String sPatternUrl = "(\\\"endpoint\\\"\\:)\\W*\\\"(.*)\\\"";
        Pattern patternUrl = Pattern.compile(sPatternUrl);
        Matcher matcherUrl = patternUrl.matcher(pbVaultKvGetOutput);
        matcherUrl.find();
        String urlString = matcherUrl.group(2);

        url = new URL(urlString);

        uri = new URI(url.getProtocol(), url.getUserInfo(), url.getHost(), url.getPort(), url.getPath(), url.getQuery(), url.getRef());
        String requestToPost = "{\"zipcode\": \"" + zipcode + "\", \"radius\": \"" + radius + "\"}";

        JSONResource response = resty.json(uri,content(new JSONObject(requestToPost)));
        JSONArray results = (JSONArray) response.get("results");

        return results;
    }

}