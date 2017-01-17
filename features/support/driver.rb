require 'capybara'
require 'selenium-webdriver'
require_relative 'capybara'



class AppDriver

  attr_reader :url

  def initialize(config)
    @config = config
    @caps = set_caps
    @url = get_url
    @capybara = DriversHandler::CapybaraConfig.new
    configure_capybara
  end

  def start
    set_driver
  end

  def resize_window(size)
    $logger.info "Resizing window to be #{size}..."
    @capybara.resize_window(size)
  end

  def reset_session!
    @capybara.reset_sessions!
  end

  def set_screenshot_name(name)
    @capybara.set_screenshot_name(name)
  end

  def get_screenshot_name
    @capybara.get_screenshot_name
  end

  def set_mainsite
    @url = get_url
    configure_capybara
    $logger.info "Adminsite is set as: #{@url}"
  end

  def set_default_max_wait_time(time)
    @capybara.set_default_max_wait_time(time)
  end

  private
  def set_caps
    caps = Selenium::WebDriver::Remote::Capabilities.new
    caps['platform'] = @config.get_param('platform', 'Windows 8')
    caps['browserName'] = @config.get_param('browserName', 'chrome')
    caps['version'] = @config.get_param('version', '46')
    caps['maxDuration'] = @config.get_param('maxDuration', '1800')
    caps['name'] = @config.get_param('remote_run_name', '')
    caps
  end

  def get_caps
    @caps
  end

  def get_url
    'http://the-internet.herokuapp.com'
  end

  def configure_capybara
    @capybara.set_app_host(@url)
    @capybara.set_screenshots_out("test_out/")
  end

  def set_driver
    driver = @config.get_param('driver_type', 'firefox')
    $logger.startup_log(driver)
    case driver
      when 'firefox'
        @capybara.start_driver(:selenium)
      when 'chrome'
        @capybara.start_driver(driver.to_sym)
      when 'remote'
        val = @config.get_param('remote_url')
        @lab = eval(val)
        @capybara.start_driver(driver.to_sym, @caps, @lab)
      else
        $logger.fatal "Unknown driver type '#{driver}'..."
    end
  end
end
