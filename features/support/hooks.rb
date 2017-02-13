require_relative '../pages/page_actions'

Dir["../pages/*.rb"].each { |file| require_relative file }

driver_path = File.join(File.dirname(__FILE__), "..", "..", "drivers", "chromedriver")


Before '@wip' do
  skip_this_scenario
end

Before do |scenario|

  if SERVER == :local && BROWSER == :chrome
    @browser = Selenium::WebDriver.for :chrome, driver_path: driver_path
    @browser.manage.window.maximize
  end

  if SERVER == :remote
    capabilities_config = {
        :version => "#{ENV['version']}",
        :platform => "#{ENV['platform']}",
        :name => "#{scenario.feature.name} - #{scenario.name}"
    }
    build_name = ENV['JENKINS_BUILD_NUMBER'] || ENV['SAUCE_BAMBOO_BUILDNUMBER'] || ENV['SAUCE_TC_BUILDNUMBER'] || ENV['SAUCE_BUILD_NAME']
    capabilities_config[:build] = build_name unless build_name.nil?

    capabilities = Selenium::WebDriver::Remote::Capabilities.send(ENV['browserName'].to_sym, capabilities_config)

    url = "https://#{ENV['SAUCE_USERNAME']}:#{ENV['SAUCE_ACCESS_KEY']}@ondemand.saucelabs.com:443/wd/hub".strip

    client = Selenium::WebDriver::Remote::Http::Default.new
    # client.timeout = 180

    @browser = Selenium::WebDriver.for(:remote, :url => url, :desired_capabilities => capabilities, :http_client => client)
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

# "after all"
After do |scenario|
  sessionid = @browser.send(:bridge).session_id
  jobname = "#{scenario.feature.name} - #{scenario.name}"

  puts "SauceOnDemandSessionID=#{sessionid} job-name=#{jobname}"

  @browser.quit

  if scenario.passed?
    SauceWhisk::Jobs.pass_job sessionid
  else
    SauceWhisk::Jobs.fail_job sessionid
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
end
