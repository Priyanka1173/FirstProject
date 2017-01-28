When(/^I login with "([^"]*)" username and "([^"]*)" password$/) do |username, password|
  @basic_auth.with(username, password)
end

Then(/^I should see the "([^"]*)" message$/) do |message|
  expect(@basic_auth.success_message.text).to eq(message)
end

When(/^I move to "([^"]*)" page$/) do |page|
  instance_variable_get("@#{page}").visit page
end

Then(/^I select "([^"]*)" from dropdown$/) do |option|
  @dropdown.select(option)
end

Then(/^I should see the "([^"]*)" selected$/) do |expected_selected_option|
  actual_selected_option = @dropdown.selected_option
  expect(actual_selected_option).to eql expected_selected_option
end


Then(/^I check if 2(st|nd|rd|th) box is selected$/) do |index|
  # TODO: read about equality matchers
  # https://www.relishapp.com/rspec/rspec-expectations/v/2-2/docs/matchers/equality-matchers
  expect(@checkboxes.is_checked? index).to eql true
end