class AbTestPage < PageActions


  def navigate
    @browser.get (BASE_URL + "/abtest")
  end

end