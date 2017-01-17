Feature: Practicing

#  Scenario: User with invalid credentials not able to login
#    Given I login with credentials
#      | username | admin |
#      | password | admin |
#    Then I should see the "Congratulations! You must have the proper credentials." message

  Scenario: A/B testing
    Given I go to abtest page
    And I should see "A/B Test Variation 1" or "A/B Test Control" headline
    When I changed cookie
    And I refresh page
    Then I should see "No A/B Test" headline
