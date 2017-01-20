driver_path = File.join(File.dirname(__FILE__),"..", "..", "drivers", "chromedriver")
p driver_path

Given(/^I open browser$/) do
  @browser = Selenium::WebDriver.for :chrome, driver_path: driver_path
  @browser.manage.timeouts.implicit_wait = 10
  @browser.manage.timeouts.page_load = 10
  puts "WebDriver has been created"
end

When(/^I login with "([^"]*)" username and "([^"]*)" password$/) do |username, password|
  puts "#{username} and #{password}"
  url = "http://#{username}:#{password}@the-internet.herokuapp.com/basic_auth"
  @browser.get url
end

Then(/^I should see the "([^"]*)" message$/) do |message|
  puts "#{message}"
  expect(@browser.find_element(:css, '.example p').text).to eq(message)
end