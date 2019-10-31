@WireMock
Feature: Zipster_WireMock

  Background: Start server
    Given I start the "WireMock" server

  Scenario: Zipcodes near Pequannock NJ
    When I look for zipcodes within "2.0" miles of "07440"
    Then it should find the following post offices
      | zipcode | zipcode_type | city           | state | location_type | latitude | longitude | location                | decomissioned | distance |
      | 07444   | STANDARD     | POMPTON PLAINS | NJ    | PRIMARY       | 40.96    | -74.30    | NA-US-NJ-POMPTON PLAINS | 0             | 1.477185 |
      | 07035   | STANDARD     | LINCOLN PARK   | NJ    | PRIMARY       | 40.92    | -74.30    | NA-US-NJ-LINCOLN PARK   | 0             | 1.477241 |
      | 07477   | UNIQUE       | WAYNE          | NJ    | PRIMARY       | 40.92    | -74.27    | NA-US-NJ-WAYNE          | 1             | 1.732069 |


  Scenario: Zipcodes near Easton CT
    When I look for zipcodes within "6.0" miles of "06612"
    Then it should find the following post offices
      | zipcode | zipcode_type | city           | state | location_type | latitude | longitude | location                | decomissioned | distance |
      | 06883   | STANDARD     | WESTON         | CT    | PRIMARY       | 41.22    | -73.37    | NA-US-CT-WESTON         | 0             | 3.410546 |
      | 06875   | PO BOX       | REDDING CENTER | CT    | PRIMARY       | 41.30    | -73.38    | NA-US-CT-REDDING CENTER | 0             | 5.513521 |
      | 06876   | PO BOX       | REDDING RIDGE  | CT    | PRIMARY       | 41.30    | -73.38    | NA-US-CT-REDDING RIDGE  | 0             | 5.513521 |
      | 06896   | STANDARD     | REDDING        | CT    | PRIMARY       | 41.30    | -73.38    | NA-US-CT-REDDING        | 0             | 5.513521 |
      | 06611   | STANDARD     | TRUMBULL       | CT    | PRIMARY       | 41.25    | -73.20    | NA-US-CT-TRUMBULL       | 0             | 5.756242 |

  Scenario: Zipcodes near Yorba Linda CA
    When I look for zipcodes within "7.0" miles of "92887"
    Then it should find the following post offices
      | zipcode | zipcode_type | city           | state | location_type | latitude | longitude | location                | decomissioned | distance |
      | 92809   | STANDARD     | ANAHEIM        | CA    | PRIMARY       | 33.86    | -117.74   | NA-US-CA-ANAHEIM        | 0             | 1.796008 |
      | 92808   | STANDARD     | ANAHEIM        | CA    | PRIMARY       | 33.84    | -117.73   | NA-US-CA-ANAHEIM        | 0             | 2.822741 |
      | 92886   | STANDARD     | YORBA LINDA    | CA    | PRIMARY       | 33.89    | -117.78   | NA-US-CA-YORBA LINDA    | 0             | 3.510008 |
      | 91709   | STANDARD     | CHINO HILLS    | CA    | PRIMARY       | 33.94    | -117.72   | NA-US-CA-CHINO HILLS    | 0             | 4.145422 |
      | 92807   | STANDARD     | ANAHEIM        | CA    | PRIMARY       | 33.85    | -117.79   | NA-US-CA-ANAHEIM        | 0             | 4.519457 |
      | 92817   | PO BOX       | ANAHEIM        | CA    | PRIMARY       | 33.85    | -117.79   | NA-US-CA-ANAHEIM        | 0             | 4.519457 |
      | 92823   | STANDARD     | BREA           | CA    | PRIMARY       | 33.92    | -117.80   | NA-US-CA-BREA           | 0             | 5.355973 |
      | 92885   | PO BOX       | YORBA LINDA    | CA    | PRIMARY       | 33.89    | -117.82   | NA-US-CA-YORBA LINDA    | 0             | 5.777190 |
      | 92862   | STANDARD     | ORANGE         | CA    | PRIMARY       | 33.79    | -117.71   | NA-US-CA-ORANGE         | 0             | 6.244857 |
      | 92867   | STANDARD     | ORANGE         | CA    | PRIMARY       | 33.81    | -117.79   | NA-US-CA-ORANGE         | 0             | 6.287095 |
      | 92880   | STANDARD     | CORONA         | CA    | PRIMARY       | 33.90    | -117.61   | NA-US-CA-CORONA         | 0             | 6.458642 |
      | 92811   | PO BOX       | ATWOOD         | CA    | PRIMARY       | 33.86    | -117.83   | NA-US-CA-ATWOOD         | 0             | 6.460086 |
      | 92859   | PO BOX       | ORANGE         | CA    | PRIMARY       | 33.80    | -117.78   | NA-US-CA-ORANGE         | 0             | 6.512262 |


  Scenario: Stop server
    Then I stop the server