@dropdown @acceptance
Feature: Selecting from a Dropdown
  Selecting from a dropdown list seems like one of those simple things.
  Just grab the list by it's element and select an item within it based on the text you want.
  While it sounds pretty straightforward, there is a bit more finesse to it.

  Scenario Outline: select options from dropdown
    Given I move to "dropdown" page
    When I select "<option>" from dropdown
    Then I should see the "<option>" selected

    Examples: options from dropdown menu
    |option  |
    |Option 1|
    |Option 2|


