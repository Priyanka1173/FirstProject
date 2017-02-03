class PageActions
  def initialize(browser)
    @browser = browser
  end

  def visit
    @browser.navigate.to self.path
  end

  def wait_for (seconds)
    Selenium::WebDriver::Wait.new(timeout: seconds).until { yield }
  end
end