package test.com.deinersoft.zipster;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)

@CucumberOptions(
//      dryRun   = false,
//      strict = true,
        tags     = "@WireMock, @Local",
        monochrome = false,
        features = { "src/test/com/deinersoft/zipster/resources/features" },
        glue     = { "test.com.deinersoft.zipster" },
        plugin   = { "pretty", "html:target/cucumber-reports-local/cucumber-html-report", "json:target/cucumber-reports-local/cucumber-json-report.json" }
)

public class CucumberTestsZipsterLocal {

}