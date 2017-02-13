require "selenium-webdriver"
require "rspec"
require 'sauce_whisk'


$base_url = (ENV['BASE'] || "the-internet.herokuapp.com").to_s

SAUCE_USERNAME = (ENV['SAUCE_USERNAME'])
SAUCE_API_KEY = (ENV['SAUCE_API_KEY'])
SERVER = (ENV['SERVER'] || :local).to_sym
BROWSER = (ENV['BROWSER'] || :chrome).to_sym
