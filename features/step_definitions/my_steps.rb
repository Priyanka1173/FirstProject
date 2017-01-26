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
