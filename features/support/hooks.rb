driver_path = File.join(File.dirname(__FILE__),"..", "..", "drivers", "chromedriver")

Before do
  @browser = Selenium::WebDriver.for :chrome, driver_path: driver_path
  puts "WebDriver has been created"
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