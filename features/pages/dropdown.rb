class Dropdown < PageActions
  DROPDOWN_ELEMENT = {id: 'dropdown'}

  def path
    "/dropdown"
  end

  def select option
    dropdown = @browser.find_element(DROPDOWN_ELEMENT)
    @select_list = Selenium::WebDriver::Support::Select.new dropdown
    @select_list.select_by(:text, option)
  end

  def selected_option
    @select_list.selected_options.each{|option| p option.text}
    @select_list.selected_options.first.text
  end

end