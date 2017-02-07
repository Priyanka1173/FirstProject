class PageActions

  def initialize(browser)
    @browser = browser
  end

  def visit  path = nil
    puts "Path variable is actually +++++#{path.class}"
    puts path

    page = self.path
    puts page

    page += path.first unless path.first.nil?

    new_url = URI::HTTP.build({:host => $base_url, :path => page })

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