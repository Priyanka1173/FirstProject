Given(/^I go to home page$/) do
  application.home_page.navigate
end

Given(/^I go to abtest page$/) do
  application.abtest_page.navigate
end

When(/^I changed cookie$/) do
  @browser.manage.add_cookie(name: 'optimizelyOptOut', value: 'true')
end

And(/^I refresh page$/) do
  @browser.navigate.refresh
end

And(/^I should see "([^"]*)" or "([^"]*)" headline$/) do |arg1, arg2|
  heading_text = @browser.find_element(css: 'h3').text
  expect([arg1, arg2].include? heading_text).to eql true
end

Then(/^I should see "([^"]*)" headline$/) do |arg|
  heading_text = @browser.find_element(css: 'h3').text
  expect(heading_text.include? arg).to eql true
end