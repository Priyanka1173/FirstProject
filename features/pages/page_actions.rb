class PageActions
  def initialize(browser)
    @browser = browser
  end

  def visit (relative_page = nil)
    @browser.navigate.to self.path relative_page
  end

  def wait_for (seconds)
    Selenium::WebDriver::Wait.new(timeout: seconds).until { yield }
  end
end