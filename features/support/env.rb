require "selenium-webdriver"
require "rspec"
$base_url = (ENV['BASE'] || "the-internet.herokuapp.com").to_s

SAUCE_USERNAME = (ENV['SAUCE_USERNAME'])
SAUCE_API_KEY = (ENV['SAUCE_API_KEY'])
SERVER = (ENV['SERVER'] || :local).to_sym
BROWSER = (ENV['BROWSER'] || :chrome).to_sym


# You can change cap's value, list of avaliable values
# https://wiki.saucelabs.com/display/DOCS/Platform+Configurator#/
def browser_caps
  if BROWSER == :chrome_windows
     { :platform => "Windows 7", :browserName => "Chrome", :version => "45" }
  elsif BROWSER == :chrome
     { :platform => "Mac OS X 10.12.3", :browserName => "Chrome", :version => "56"}
  elsif BROWSER == :firefox
     { :platform => "Mac OS X 10.10.5", :browserName => "Firefox", :version => "48" }
  end
end