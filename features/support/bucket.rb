require 'securerandom'
require 'capybara'

module Bucket
  include Capybara::DSL

  def format_page_to_class(page)
    page.downcase.delete(' ').capitalize
  end

  def init_page(namespace, to_eval)
    to_eval = to_eval.to_s.split('_').collect(&:capitalize).join
    eval("#{namespace}::#{to_eval}Page.new")
  end

  def format_to_page(page_name)
    format_to_variable(page_name) + "_page"
  end

  def format_to_variable(value)
    value.downcase.gsub(/\s/, '_').gsub('-','_')
  end

  def pop_up(action)
    if page.driver.class == Capybara::Selenium::Driver
      begin
        if action == ('Confirm' || 'Accept')
          page.driver.browser.switch_to.alert.accept
        elsif action == ('Cancel' || 'Dismiss')
          page.driver.browser.switch_to.alert.dismiss
        end
      rescue
        Selenium::WebDriver::Error::NoSuchAlertError
      end
    end
  end

  def find_popup
    wait = Selenium::WebDriver::Wait.new ignore: Selenium::WebDriver::Error::NoAlertPresentError
    wait.until { page.driver.browser.switch_to.alert }
  end

  def popup?
    begin
      page.driver.browser.switch_to.alert
      true
    rescue Selenium::WebDriver::Error::NoSuchAlertError
      false
    end
  end

  def stamp(value)
    timestamp = Time.now.strftime("%m%d%Y%H%M%S%L")
    valid = '[^ @]+'
    valid_email = /^#{valid}@#{valid}\.#{valid}/
    value.match(valid_email) ? value.gsub(/^#{valid}/, value[/^#{valid}/] + "_user_#{timestamp}") : "#{value}#{timestamp}"
  end

  def self.stamp(value)
    timestamp = Time.now.strftime("%m%d%Y%H%M%S%L")
    valid = '[^ @]+'
    valid_email = /^#{valid}@#{valid}\.#{valid}/
    value.match(valid_email) ? value.gsub(/^#{valid}/, value[/^#{valid}/] + "_user_#{timestamp}") : "#{value}#{timestamp}"
  end

  def search_for_criteria(array_of_objects, value, arg="text")
    array_of_objects.each do |object|
      if arg == 'text'
        return object if object.text == value
      else
        return object if object[arg].match value
      end
    end
  end

  #Use wait_for_ajax for tests that needs to wait on ajax requests
  def wait_for_ajax(timeout = Capybara.default_max_wait_time)
    begin
      if page.evaluate_script("typeof jQuery != 'undefined'")
        Timeout.timeout(timeout) do
          $logger.info "start finished_all_ajax_requests"
          loop until finished_all_ajax_requests?
          $logger.info "finished finished_all_ajax_requests"
        end
      else
        $logger.info "JQuery is not loaded"
      end
    rescue
      $logger.warn "wait for Ajax, rescue block"
    end
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end

  def click_on_ (button)
    @current_page.click_on(button)
    self
  end


  #symbolize elements in hash, an array or an obj
  def symbolize(obj)
    return obj.reduce({}) do |memo, (k, v)|
      memo.tap { |m| m[k.to_sym] = symbolize(v) }
    end if obj.is_a? Hash

    return obj.reduce([]) do |memo, v|
      memo << symbolize(v); memo
    end if obj.is_a? Array

    obj
  end

  #Waits until the block returns true, similar method as "wait_until" from Capybara
  def evaluate_for(timeout = Capybara.default_max_wait_time)
    previous_capybara_time = Capybara.default_max_wait_time
    Capybara.default_max_wait_time = timeout
    Timeout.timeout(timeout) do
      sleep(0.05) until yield == true
    end
  ensure
    Capybara.default_max_wait_time = previous_capybara_time
  end

  def self.select_option(dropdown_elem, option)
    dropdown_elem.find("option[value='#{option}']").select_option
  end

  def resize_window_browser(width, height)
    window = page.driver.browser.manage.window
    window.resize_to(width, height)
  end

end

