require_relative 'driver'
require 'require_all'


class SetUp

  def initialize(config)
    $logger.initializing_object('Setup')
    @config = config
    @driver = AppDriver.new(@config)
  end

  def load_page_objects
    $logger.info 'Loading all page object files...'
    require_all 'page_objects'
  end

  def resize_window(size)
    @driver.resize_window(size) if @config.get_param('driver_type') != "remote"
  end

  def url
    @driver.url
  end

  def load_factories
    path = File.dirname(__FILE__) + "/../../data"
    data_objects = '/objects'
    factories = '/factories'
    require_all path + data_objects
    require_all path + factories
    FactoryGirl.definition_file_paths = %w(path)
    FactoryGirl.find_definitions
  end

  def load_errors
    path = File.dirname(__FILE__)
    require_all(path + '/errors.rb')
  end

  def reset_session!
    $logger.info 'Resetting current session (cleaning cookie)...'
    @driver.reset_session!
  end

  def set_default_max_wait_time(time)
    @driver.set_default_max_wait_time(time)
  end

  def screentshot_name(name)
    $logger.info 'Setting custom screenshot name...'
    @driver.set_screenshot_name(name)
  end

  def get_screenshot_name
    @driver.get_screenshot_name
  end

  def prepare_system
    $logger.info 'Request to prepare the system has been relieved...'
    @driver.start
  end

  def cleanup_testout
    if @config.get_param('cleaning', 'true') == 'true'
      $logger.info 'Cleaning up test_out folder...'
      FileUtils.rm_rf(Dir.glob('test_out/*'))
    else
      $logger.info 'Holding with test out cleaning as was specified in configs...'
    end
  end

  def load_mainsite
    @driver.set_mainsite
  end

  def current_platform
    @config.get_param('platform')
  end

  def current_browser_name
    @config.get_param('browserName')
  end

end


