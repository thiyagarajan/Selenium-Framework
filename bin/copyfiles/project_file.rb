require './include.rb'

class Project < Test::Unit::TestCase

  @@browser = "firefox"
  @@build = 1
  $screenshot_directory_path = PreRequisite.create_screenshot_directory_path(Dir.pwd.to_s, @@build, @@browser, UserExtension.current_timestamp)
  $report_file = PreRequisite.create_report_file(Dir.pwd.to_s, @@build, @@browser, UserExtension.current_timestamp)
  $log_file = PreRequisite.create_log_file(Dir.pwd.to_s, @@build, @@browser, UserExtension.current_timestamp)

  SeleniumConfig = YAML.load_file(Dir.pwd.to_s + '/Libraries/selenium-framework.yml')

  def setup
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.timeout = 120 # seconds
    $driver = Selenium::WebDriver.for(:remote, :http_client => client, :url => 'http://<IP ADDRESS>:<PORT NUMBER>/wd/hub', :desired_capabilities => @@browser.to_sym)
    $base_url = 'http://<WEBSITE URL>'
    $driver.manage.timeouts.implicit_wait = 180
    @verification_errors = []
  end

  def teardown
    $driver.quit
    assert_equal [], @verification_errors
  end

  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end

end