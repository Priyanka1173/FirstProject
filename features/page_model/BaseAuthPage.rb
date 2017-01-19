class BaseAuthPage < PageActions

  # element :message, '.example p'
  def message
    @browser.find_element(:css, '.example p')
  end

  def login(username, password)
    url = "http://#{username}:#{password}@the-internet.herokuapp.com/basic_auth"
    @browser.get url
  end

end
