@dynamic @acceptance
Feature: Dynamic Loading
  It's common to see an action get triggered that returns a result dynamically.
  It does not rely on the page to reload or finish loading.
  The page automatically gets updated (e.g. hiding elements, showing elements, updating copy, etc) through the use of JavaScript.
  There are two examples. One in which an element already exists on the page but it is not displayed.
  Another case where the element is not on the page and gets added in.

  Scenario: select options from dropdown
    Given I move to "dynamic_loading" page
    When I clink on start button
    Then "Hello World!" message is displayed