And(/^I go to my "([^"]*)" page$/) do |page|
  pagename = format_to_page(page)
  @current_page = app.send(pagename)

  if page == 'Basic Auth'
    @current_page.login(@main_user)
  else
    @current_page.load
  end

  $logger.info "Initialized #{pagename} page"
end

Then(/^I (should|shouldn't) see the "([^"]*)" message$/) do |opt, message|
  if opt == "shouldn't"
    expect(@current_page.has_content?(message)).to be_falsy
  else
    expect(@current_page.message.text).to eq(message)
  end

end
