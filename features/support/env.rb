require "selenium-webdriver"
require "rspec"
require "pry"

require File.join(File.dirname(__FILE__),"..", "page_model", "page_actions.rb")

SAUCE_USERNAME = (ENV['SAUCE_USERNAME'])
SAUCE_API_KEY = (ENV['SAUCE_API_KEY'])

BASE_URL = (ENV['BASE_URL'] || "http://the-internet.herokuapp.com")

# Set server to :remote or :local
SERVER = (ENV['SERVER'] || :local).to_sym
# Set browser to :chrome, :firefox if server == local
# Set browser to :chrome_windows, :chrome, :firefox if if server == remote

BROWSER = (ENV['BROWSER'] || :chrome).to_sym
DEFAULT_TIMEOUT = 30

def application
  Application.new @browser
end

def take_screenshot file_name
  @browser.save_screenshot "features/screenshots/#{file_name}"
end

# You can change cap's value, list of avaliable values
# https://wiki.saucelabs.com/display/DOCS/Platform+Configurator#/
def browser_caps
  if BROWSER == :chrome_windows
    return { :platform => "Windows 7", :browserName => "Chrome", :version => "45" }
  elsif BROWSER == :chrome
    return { :platform => "Mac OS X 10.12.2", :browserName => "Chrome", :version => "55"}
  elsif BROWSER == :firefox
    return { :platform => "Mac OS X 10.10.5", :browserName => "Firefox", :version => "48" }
  end
end


