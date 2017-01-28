class Checkboxes
  CHECKBOXES = {css: 'input[type="checkbox"]'}

  def initialize(browser)
    @browser = browser
  end

  def visit page
    @browser.get "http://the-internet.herokuapp.com/#{page}"
  end

  def is_checked? index
    checkboxes = @browser.find_elements(CHECKBOXES)
    checkboxes[index.to_i - 1].selected?
  end

end