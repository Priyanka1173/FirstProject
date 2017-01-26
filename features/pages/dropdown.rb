class Dropdown
  DROPDOWN_ELEMENT = {id: 'dropdown'}

  def initialize(browser)
    @browser = browser
  end

  def visit page
    @browser.get "http://the-internet.herokuapp.com/#{page}"
  end

  def select option
    dropdown = @browser.find_element(DROPDOWN_ELEMENT)
    @select_list = Selenium::WebDriver::Support::Select.new dropdown
    @select_list.select_by(:text, option)
  end

  def selected_option
    @select_list.selected_options[0].text
  end

end