require "selenium-webdriver"
require "rspec"

After do
  @browser.quit
end