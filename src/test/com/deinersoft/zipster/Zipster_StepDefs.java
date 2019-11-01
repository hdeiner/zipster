package test.com.deinersoft.zipster;

import cucumber.api.DataTable;
import com.deinersoft.zipster.core.PostOffice;
import org.json.JSONObject;
import test.java.com.deinersoft.zipster.client.ZipsterClient;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import us.monoid.json.JSONArray;


import java.util.List;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;

public class Zipster_StepDefs {
    private static String whichServerStarted = "";
    private static ZipsterClient zipsterClient;

    private String test_zipcode;
    private String test_radius;

    @Given("^I start the \"([^\"]*)\" server$")
    public void i_start_the_local_server(String whichServer) throws Throwable {
        if (!whichServerStarted.equals(whichServer)) {
            if (!whichServerStarted.equals("")) zipsterClient.stopServer();
            zipsterClient = new ZipsterClient(whichServer);
            zipsterClient.startServer();
            whichServerStarted = whichServer;
        }
    }

    @Then("^I stop the server$")
    public void i_stop_the_server() throws Throwable {
        if (!whichServerStarted.equals("")) zipsterClient.stopServer();
        whichServerStarted = "";
    }

    @When("^I look for zipcodes within \"([^\"]*)\" miles of \"([^\"]*)\"$")
    public void i_look_for_zipcodes_within_miles_of(String radius, String zipcode) throws Throwable {
        this.test_radius = radius;
        this.test_zipcode = zipcode;
    }

    @Then("^it should find the following post offices$")
    public void it_should_find_the_following_post_offices(DataTable postOffices) throws Throwable {
        List<PostOffice> postOfficesExpected = postOffices.asList(PostOffice.class);

        JSONArray postOfficesReturned = zipsterClient.getPostOfficesWithinRadius(test_zipcode, test_radius);

        boolean foundAllRows = true;
        int rowsReturned = postOfficesReturned.length();
        for (int i=0; i<rowsReturned; i++) {
            String returnedRow = postOfficesReturned.get(i).toString();
            JSONObject jsonObject = new JSONObject(returnedRow);
            PostOffice postOfficeRowReturned = new PostOffice(
                    jsonObject.getString("zipcode"),
                    jsonObject.getString("zipcode_type"),
                    jsonObject.getString("city"),
                    jsonObject.getString("state"),
                    jsonObject.getString("location_type"),
                    jsonObject.getString("latitude"),
                    jsonObject.getString("longitude"),
                    jsonObject.getString("location"),
                    jsonObject.getString("decomissioned"),
                    jsonObject.getString("distance")
                    );
            boolean foundRow = false;
            for (int j = 0; j<postOfficesExpected.size(); j++ ) {
                if ( (!foundRow) &&
                        (postOfficesExpected.get(j).zipcode.equals(postOfficeRowReturned.zipcode)) &&
                        (postOfficesExpected.get(j).zipcode_type.equals(postOfficeRowReturned.zipcode_type)) &&
                        (postOfficesExpected.get(j).city.equals(postOfficeRowReturned.city)) &&
                        (postOfficesExpected.get(j).state.equals(postOfficeRowReturned.state)) &&
                        (postOfficesExpected.get(j).location_type.equals(postOfficeRowReturned.location_type)) &&
                        (postOfficesExpected.get(j).latitude.equals(postOfficeRowReturned.latitude)) &&
                        (postOfficesExpected.get(j).longitude.equals(postOfficeRowReturned.longitude)) &&
                        (postOfficesExpected.get(j).location.equals(postOfficeRowReturned.location)) &&
                        (postOfficesExpected.get(j).decomissioned.equals(postOfficeRowReturned.decomissioned))
//                        (postOfficesExpected.get(j).distance.equals(postOfficeRowReturned.distance))
                ) {
                    foundRow = true;
                }
            }
            if (!foundRow) {
                foundAllRows = false;
            }
        }
        assertThat(foundAllRows, is(true));
    }

}
