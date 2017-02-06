class PageActions
  def initialize(browser)
    @browser = browser
  end

  def visit path = nil
    page = self.path

    if path.nil? || path.first.nil?
      page
    else
      page = page + path.first
    end

    new_url = URI::HTTP.build({:host => $base_url, :path => page})
    puts new_url
    @browser.navigate.to new_url
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