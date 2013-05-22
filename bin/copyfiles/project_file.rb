require './include.rb'

class Project < Test::Unit::TestCase

  build_path = PreRequisite.create_build_structure(Dir.pwd)
  $screenshot_directory_path = PreRequisite.create_screenshot_directory_path(Dir.pwd.to_s, build_path)
  $report_file = PreRequisite.create_report_file(Dir.pwd.to_s, build_path)
  $log_file = PreRequisite.create_log_file(Dir.pwd.to_s, build_path)
  $SeleniumConfig = YAML.load_file(Dir.pwd.to_s + '/config/selenium-framework.yml')
  $app_path = Dir.pwd

  def setup
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.timeout = 120 # seconds
    if $SeleniumConfig.mode == "remote"
      $driver = Selenium::WebDriver.for(:remote, :http_client => client, :url => 'http://'+ $SeleniumConfig.host+':4444/wd/hub', :desired_capabilities => $SeleniumConfig.local_browser.to_sym)
    else
      $driver = Selenium::WebDriver.for $SeleniumConfig.local_browser.to_sym
    end
    $base_url = $SeleniumConfig.base_url
    $adminbase_url = $SeleniumConfig.adminbase_url
    $driver.manage.timeouts.implicit_wait = 180
    @verification_errors = []
  end

  # Write the testcases here:

  def test_zipandmail
    Utility.email('from_email_id', 'to_email_id', 'cc_email_id', 'project_name', $report_file)
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