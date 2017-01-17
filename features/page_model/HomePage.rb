class HomePage < PageActions

  def navigate
    url = BASE_URL
    @browser.get url
  end

end

