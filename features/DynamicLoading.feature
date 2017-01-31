@dynamic
Feature: Dynamic Loading
  Selecting from a dropdown list seems like one of those simple things.
  Just grab the list by it's element and select an item within it based on the text you want.
  While it sounds pretty straightforward, there is a bit more finesse to it.

  Scenario: select options from dropdown
    Given I move to "dynamic_loading" page
    When I clink on start button
    Then "Hello World!" message is displayed