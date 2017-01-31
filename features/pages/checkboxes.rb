class Checkboxes < PageActions
  CHECKBOXES = {css: 'input[type="checkbox"]'}

  def path
    "http://the-internet.herokuapp.com/checkboxes"
  end

  def is_checked? index
    checkboxes = @browser.find_elements(CHECKBOXES)
    checkboxes[index.to_i - 1].selected?
  end

end