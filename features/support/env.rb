require "selenium-webdriver"
require "rspec"
require_relative 'site'
Dir["../pages/*.rb"].each {|file| require_relative file}

$base_url = (ENV['BASE'] || "the-internet.herokuapp.com").to_s

World {Site.new @browser}