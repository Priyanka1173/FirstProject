@login
Feature: Basic Authentication

  @acceptance
  Scenario: User with valid credential can login
    When I login with "admin" username and "admin" password
    Then I should see the "Congratulations! You must have the proper credentials." message

