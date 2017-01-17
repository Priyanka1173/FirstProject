class Application < PageActions

  def base_auth_page
    @base_auth_page ||= BaseAuthPage.new @browser
  end

  def home_page
    @home_page ||= HomePage.new @browser
  end

  def abtest_page
    @abtest_page ||= AbTestPage.new @browser
  end

end
