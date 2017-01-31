@checkboxes @acceptance
Feature: Checkboxes
  The Problem

  Checkboxes are an often used element in web applications.
  How do you work with them in your Selenium tests?
  Intuitively you may reach for a method that has the word 'checked' in it -- like .checked?
  or .isChecked. But this doesn't exist in Selenium. So how do you do it?

  A Solution

  There are two ways to approach this --
  by seeing if an element has a checked attribute (a.k.a. performing an attribute lookup),
  or by asking an element if it has been selected.

#  this scenario is exercising second approach
  Scenario: select options from dropdown
    Given I move to "checkboxes" page
    Then I check if 2nd box is selected