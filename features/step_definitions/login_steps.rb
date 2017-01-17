
Then(/^I should see the "([^"]*)" message$/) do |message|
    expect(application.base_auth_page.message.text).to eq(message)
end

Given(/^I login with credentials$/) do |table|
  cred = table.rows_hash
  application.base_auth_page.login(cred['username'], cred['password'])
end
