class DynamicLoading < PageActions
  START_BUTTON = {css: '#start button'}
  FINISH_ELEMENT = {css: '#finish'}

  def path relative_page
    "http://the-internet.herokuapp.com/dynamic_loading#{relative_page}"
  end

  def start_button
    @browser.find_element(START_BUTTON)
  end

  def finish_element
    @browser.find_element(FINISH_ELEMENT)
  end

  def success_message_displayed?
    wait_for(10){finish_element.displayed?}
  end
end