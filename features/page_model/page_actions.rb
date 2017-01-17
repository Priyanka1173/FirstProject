class PageActions

  def initialize browser
    @browser = browser
  end

  def self.element(name, finder)
    define_method(name) do
      begin
        wait_for_element{@browser.find_element(finder)}
      rescue => e
        raise e, "#{name} cannot be found using #{finder}"
      end
    end
  end

  def wait_for_element(timeout=30, &block)
      wait = Selenium::WebDriver::Wait.new(:timeout => timeout)
      wait.until{yield}
  end

  def with_reduced_timeout(&block)
    @browser.manage.timeouts.implicit_wait = 1
    result = yield
    @browser.manage.timeouts.implicit_wait = DEFAULT_TIMEOUT
    result
  end

  def wait_for(timeout = 10, &block)
    @result=nil
    end_time = Time.now.to_i + timeout
    until Time.now.to_i > end_time
      begin
        @result = with_reduced_timeout{yield}
        return @result if @result
      rescue Selenium::WebDriver::Error::NoSuchElementError
        nil
      end
    end
    if @result == nil || @result == false
      raise "Timeout exceeded, block not succeeded"
    elsif @result == true
      return true
    end
  end

  # this block will wait for text on a page
  def wait_for_text(timeout = 60, text)
    wait_for(timeout){@browser.page_source.include? text}
  end
  # this block will wait for an element on the page
  def wait_for_element_displayed(timeout = 60, element)
    wait_for(timeout){element.displayed?}
  end

end