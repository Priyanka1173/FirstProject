require 'factory_girl'
require_relative 'setup'
require_relative 'configuration'
require 'site_prism'
require_relative 'bucket'
require 'capybara-screenshot/cucumber'
require_relative '../../lib/logger/sparklog'
require_relative '../../lib/pom/page'
require_relative 'assertions'
require 'pry'
require 'active_support'
require 'benchmark'

#Creating a logfile and making it accessable through the framework
$logger = Applog.new("application#{ENV['TEST_ENV_NUMBER']}.log")
#Retrieving the main setup interface with current configurations
c = Configuration.new
$setup = SetUp.new(c)


#Requiring factories, so they are available in steps like 'FactoryGirl.create(:user)'
World(FactoryGirl::Syntax::Methods)
$setup.load_factories
#Loading Bucket module which is meant to contain some functions that you want to add , but probably
#not going to use that often
World(Bucket)

#Cleaning up old tests results
$setup.cleanup_testout
$setup.set_default_max_wait_time(5)
#Loading page objects so they are accessible in steps
$setup.load_page_objects
$setup.load_errors

#This meant to register drivers, setup all necessary configs

$setup.prepare_system

def app
  $logger.info "Instantiating App Class"
  PageObjects::MainApplication.new
end
