@login  @acceptance
Feature: Basic Authentication

  Scenario: User with valid credential can login
    Given I login with "admin" username and "admin" password
    When I should see the "Congratulations! You must have the proper credentials." message

