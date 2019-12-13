@Concrete
Feature: Zipster_Concrete

  Background: Start server
    Given I use the "Concrete" server

  Scenario: Zipcodes near Pequannock NJ
    When I look for zipcodes within "2.0" miles of "07440"
    Then it should find the following post offices
      | zipcode | zipcode_type | city           | state | location_type | latitude | longitude | location                | decomissioned | distance          |
      | 07444   | STANDARD     | POMPTON PLAINS | NJ    | PRIMARY       | 40.96    | -74.3     | NA-US-NJ-POMPTON PLAINS | 0             | 1.477185115083272 |
      | 07035   | STANDARD     | LINCOLN PARK   | NJ    | PRIMARY       | 40.92    | -74.3     | NA-US-NJ-LINCOLN PARK   | 0             | 1.477240978042409 |
      | 07477   | UNIQUE       | WAYNE          | NJ    | PRIMARY       | 40.92    | -74.27    | NA-US-NJ-WAYNE          | 1             | 1.732068600965657 |

  Scenario: Zipcodes near Easton CT
    When I look for zipcodes within "6.0" miles of "06612"
    Then it should find the following post offices
      | zipcode | zipcode_type | city           | state | location_type | latitude | longitude | location                | decomissioned | distance           |
      | 06883   | STANDARD     | WESTON         | CT    | PRIMARY       | 41.22    | -73.37    | NA-US-CT-WESTON         | 0             | 3.4105464758201736 |
      | 06875   | PO BOX       | REDDING CENTER | CT    | PRIMARY       | 41.3     | -73.38    | NA-US-CT-REDDING CENTER | 0             | 5.513520502095821  |
      | 06876   | PO BOX       | REDDING RIDGE  | CT    | PRIMARY       | 41.3     | -73.38    | NA-US-CT-REDDING RIDGE  | 0             | 5.513520502095821  |
      | 06896   | STANDARD     | REDDING        | CT    | PRIMARY       | 41.3     | -73.38    | NA-US-CT-REDDING        | 0             | 5.513520502095821  |
      | 06611   | STANDARD     | TRUMBULL       | CT    | PRIMARY       | 41.25    | -73.2     | NA-US-CT-TRUMBULL       | 0             | 5.756241520902255  |

  Scenario: Zipcodes near Yorba Linda CA
    When I look for zipcodes within "7.0" miles of "92887"
    Then it should find the following post offices
      | zipcode | zipcode_type | city           | state | location_type | latitude | longitude | location                | decomissioned | distance           |
      | 92809   | STANDARD     | ANAHEIM        | CA    | PRIMARY       | 33.86    | -117.74   | NA-US-CA-ANAHEIM        | 0             | 1.7960075587809228 |
      | 92808   | STANDARD     | ANAHEIM        | CA    | PRIMARY       | 33.84    | -117.73   | NA-US-CA-ANAHEIM        | 0             | 2.8227409528346716 |
      | 92886   | STANDARD     | YORBA LINDA    | CA    | PRIMARY       | 33.89    | -117.78   | NA-US-CA-YORBA LINDA    | 0             | 3.510008209335529  |
      | 91709   | STANDARD     | CHINO HILLS    | CA    | PRIMARY       | 33.94    | -117.72   | NA-US-CA-CHINO HILLS    | 0             | 4.145421652529151  |
      | 92807   | STANDARD     | ANAHEIM        | CA    | PRIMARY       | 33.85    | -117.79   | NA-US-CA-ANAHEIM        | 0             | 4.519457486241159  |
      | 92817   | PO BOX       | ANAHEIM        | CA    | PRIMARY       | 33.85    | -117.79   | NA-US-CA-ANAHEIM        | 0             | 4.519457486241159  |
      | 92823   | STANDARD     | BREA           | CA    | PRIMARY       | 33.92    | -117.8    | NA-US-CA-BREA           | 0             | 5.355973218580361  |
      | 92885   | PO BOX       | YORBA LINDA    | CA    | PRIMARY       | 33.89    | -117.82   | NA-US-CA-YORBA LINDA    | 0             | 5.777190428276224  |
      | 92862   | STANDARD     | ORANGE         | CA    | PRIMARY       | 33.79    | -117.71   | NA-US-CA-ORANGE         | 0             | 6.244835673064102  |
      | 92867   | STANDARD     | ORANGE         | CA    | PRIMARY       | 33.81    | -117.79   | NA-US-CA-ORANGE         | 0             | 6.287095157556475  |
      | 92880   | STANDARD     | CORONA         | CA    | PRIMARY       | 33.9     | -117.61   | NA-US-CA-CORONA         | 0             | 6.458641676046268  |
      | 92811   | PO BOX       | ATWOOD         | CA    | PRIMARY       | 33.86    | -117.83   | NA-US-CA-ATWOOD         | 0             | 6.460086398727319  |
      | 92859   | PO BOX       | ORANGE         | CA    | PRIMARY       | 33.8     | -117.78   | NA-US-CA-ORANGE         | 0             | 6.512262297105051  |
