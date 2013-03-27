require './include.rb'

class Project < Test::Unit::TestCase

def setup 
client = Selenium::WebDriver::Remote::Http::Default.new 
client.timeout = 120 # seconds 
$driver = Selenium::WebDriver.for(:remote, :http_client => client, :url => 'http://<IP ADDRESS>:<PORT NUMBER>/wd/hub', :desired_capabilities => ':firefox')
$base_url = 'http://<WEBSITE URL>'
$driver.manage.timeouts.implicit_wait = 180
@verification_errors = []
end

def teardown 
$driver.quit 
assert_equal [],@verification_errors 
end

def verify(&blk) 
yield 
rescue Test::Unit::AssertionFailedError => ex 
@verification_errors << ex 
end

end