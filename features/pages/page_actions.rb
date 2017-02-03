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

  def switch_to frame
    @browser.switch_to.frame frame
  end

  def switch_to_default
    @browser.switch_to.default_content
  end
end