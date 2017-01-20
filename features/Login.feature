Feature: Basic Authentication

  Scenario: User with valid credential can login
    Given I open browser
    When I login with "admin" username and "admin" password
    Then I should see the "Congratulations! You must have the proper credentials." message

