Feature: Selecting from a Dropdown
  Selecting from a dropdown list seems like one of those simple things.
  Just grab the list by it's element and select an item within it based on the text you want.
  While it sounds pretty straightforward, there is a bit more finesse to it.

  Scenario: select option one from dropdown
    Given I open browser
    Then I move to "dropdown" page
    When I select "Option 1" from dropdown
    Then I should see the "Option 1" selected
