require "selenium-webdriver"
require "rspec"
require_relative '../pages/page_actions'

Dir["../pages/*.rb"].each {|file| require_relative file}

driver_path = File.join(File.dirname(__FILE__),"..", "..", "drivers", "chromedriver")

Before do
  @browser = Selenium::WebDriver.for :chrome, driver_path: driver_path
  # @browser.manage.timeouts.implicit_wait = 3
  # @browser.manage.timeouts.page_load = 3
  puts "WebDriver has been created"

  @basic_auth = BasicAuth.new @browser
  @dropdown = Dropdown.new @browser
  @checkboxes = Checkboxes.new @browser
  @dynamic_loading = DynamicLoading.new @browser
end

After do
  @browser.quit
end