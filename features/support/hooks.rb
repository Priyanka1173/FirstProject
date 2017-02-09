require_relative '../pages/page_actions'

Dir["../pages/*.rb"].each {|file| require_relative file}

driver_path = File.join(File.dirname(__FILE__),"..", "..", "drivers", "chromedriver")

Before do
  if SERVER == :local && BROWSER == :chrome
    @browser = Selenium::WebDriver.for :chrome, driver_path: driver_path
    @browser.manage.window.maximize
  end

  if SERVER == :remote
    sauce_endpoint = "http://#{SAUCE_USERNAME}:#{SAUCE_API_KEY}@ondemand.saucelabs.com:80/wd/hub"
    @browser = Selenium::WebDriver.for :remote, :url => sauce_endpoint, :desired_capabilities => browser_caps
  end

  # @browser.manage.timeouts.implicit_wait = 3
  # @browser.manage.timeouts.page_load = 3
  puts "WebDriver has been created"

  @basic_auth = BasicAuth.new @browser
  @dropdown = Dropdown.new @browser
  @checkboxes = Checkboxes.new @browser
  @dynamic_loading = DynamicLoading.new @browser
  @tinymce = Tinymce.new @browser
end

After do |scenario|
  if scenario.failed?
    screenshots_dir = File.join(File.dirname(__FILE__), "..", "..", "screenshots")
    unless File.directory?(screenshots_dir)
      FileUtils.mkdir_p(screenshots_dir)
    end

    time_stamp = Time.now.strftime("%Y-%m-%d_at_%H.%M.%S").to_s
    screenshot_name = "#{time_stamp}_failure_#{scenario.name.gsub(/[^\w`~!@#\$%&\(\)_\-\+=\[\]\{\};:',]/, '-')}.png"
    screenshot_file = File.join(screenshots_dir, screenshot_name)
    @browser.save_screenshot(screenshot_file)
    embed("#{screenshot_file}", 'image/png')
  end
  @browser.quit
end