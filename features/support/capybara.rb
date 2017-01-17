require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'

module DriversHandler

  class CapybaraConfig
    include Capybara::DSL

    def register_driver(driver, caps, url)
      $logger.info "Registering driver '#{driver}' with caps as '#{caps}'..."
      driver = driver.to_sym
      case driver
        when :remote
          Capybara.register_driver driver do |app|
            dr = Capybara::Selenium::Driver.new(app, :browser => driver, :url => url, :desired_capabilities => caps)
            dr.browser.file_detector = lambda do |args|
              # args => ["/path/to/file"]
              str = args.first.to_s
              str if File.exist?(str)
            end
            dr
          end
        when :chrome
          Capybara.register_driver driver do |app|
            Capybara::Selenium::Driver.new(app, :browser => :chrome)
          end
          Capybara.javascript_driver = :chrome
        when :selenium
          Capybara.register_driver driver do |app|
            Capybara::Selenium::Driver.new(app, :browser => :firefox )
          end
        else
          $logger.fatal "Unsupported driver '#{driver}'"
      end
      register_screenshot_driver(driver)
      Capybara::Screenshot.append_timestamp = true
    end

    def set_default_max_wait_time(timeout)
      Capybara.default_max_wait_time = timeout
    end

    def resize_window(size)
      if size == 'max'
        Capybara.page.driver.browser.manage.window.maximize
      else
        Capybara.page.driver.browser.manage.window.resize_to(size)
      end
    end


    def start_driver(driver, caps=nil, url=nil)
      register_driver(driver, caps, url)
      set_current_driver(driver)
    end

    def register_screenshot_driver(d)
      Capybara::Screenshot.register_driver(d) do |driver, path|
        driver.browser.save_screenshot(path)
      end
    end

    def set_default_driver(driver)
      $logger.info "Setting default driver as #{driver}..."
      Capybara.default_driver = driver
    end

    def set_current_driver(driver)
      $logger.info "Setting current driver as #{driver}"
      Capybara.current_driver = driver
    end

    def set_app_host(url)
      $logger.info "Setting app host as #{url}..."
      Capybara.app_host = url
    end


    def set_screenshots_out(path)
      $logger.info 'Configuring Capybara....'
      Capybara.save_and_open_page_path = path
    end

    def set_screenshot_name(namee)
      @screenshot_name = namee
      Capybara::Screenshot.register_filename_prefix_formatter(:cucumber) do
        "/screenshot/#{namee}"
      end
    end

    def get_screenshot_name
      @screenshot_name
    end

    def reset_sessions!
      $logger.info "Reseting session..."
      Capybara.reset_sessions!
    end

  end
end
