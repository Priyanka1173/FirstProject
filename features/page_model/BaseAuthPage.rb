class BaseAuthPage < PageActions

  element :message, '#content p'

  def login(username, password)
    url = "http://#{username}:#{password}@the-internet.herokuapp.com/bath_auth"
    @browser.get url
  end

end
