
Feature: Basic Authorization functionality

  Scenario: User with invalid credentials not able to login
    Given I have a "main_user" object
#    table is optional, params from table will overwrite factory object
      | username | test  |
      | password | admin |
    And I go to my "Basic Auth" page
    Then I shouldn't see the "Congratulations! You must have the proper credentials." message


  Scenario: User with valid credentials able to login
    Given I have a "main_user" object
    And I go to my "Basic Auth" page
    Then I should see the "Congratulations! You must have the proper credentials." message


