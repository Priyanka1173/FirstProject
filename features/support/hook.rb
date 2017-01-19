
Before do
  if SERVER == :local && BROWSER == :chrome
    @browser = Selenium::WebDriver.for BROWSER, driver_path: "/Users/idorovskikh/ba_qa_repos/CucumberWeb/drivers/chromedriver"
    @browser.manage.window.maximize
  end

  if SERVER == :remote
    sauce_endpoint = "http://#{SAUCE_USERNAME}:#{SAUCE_API_KEY}@ondemand.saucelabs.com:80/wd/hub"
    @browser = Selenium::WebDriver.for :remote, :url => sauce_endpoint, :desired_capabilities => browser_caps
  end
end

After do |scenario|
  if scenario.failed?
    screenshots_dir = File.join(File.dirname(__FILE__), "..", "../test_out")
    if !File.directory?(screenshots_dir)
      raise "!!!Cannot capture screenshots!!! Screenshot directory #{screenshots_dir} exists but isn't a directory" if File.exists? screenshots_dir
      FileUtils.mkdir_p(screenshots_dir)
    end

    time_stamp = Time.now.strftime("%Y-%m-%d_at_%H.%M.%S").to_s
    screenshot_name = "#{time_stamp}_failure_#{scenario.name.gsub(/[^\w`~!@#\$%&\(\)_\-\+=\[\]\{\};:',]/, '-')}.png"
    screenshot_file = File.join(screenshots_dir, screenshot_name)
    sleep 1
    @browser.save_screenshot(screenshot_file)
    embed("#{screenshot_file}", 'image/png') #embed screenshot to our browser
  end
  @browser.quit if @browser !=nil
end
