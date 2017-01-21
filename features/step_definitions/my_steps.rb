When(/^I login with "([^"]*)" username and "([^"]*)" password$/) do |username, password|
  puts "#{username} and #{password}"
  url = "http://#{username}:#{password}@the-internet.herokuapp.com/basic_auth"
  @browser.get url
end

Then(/^I should see the "([^"]*)" message$/) do |message|
  puts "#{message}"
  expect(@browser.find_element(:css, '.example p').text).to eq(message)
end

Then(/^I move to "([^"]*)" page$/) do |page|
  @browser.get "http://the-internet.herokuapp.com/#{page}"
end

When(/^I select "([^"]*)" from dropdown$/) do |option|
  dropdown = @browser.find_element(id: 'dropdown')
  @select_list = Selenium::WebDriver::Support::Select.new(dropdown)
  @select_list.select_by(:text, option)
end

Then(/^I should see the "([^"]*)" selected$/) do |expected_selected_option|
  actual_selected_option = @select_list.selected_options[0].text
  expect(actual_selected_option).to eql expected_selected_option
end


