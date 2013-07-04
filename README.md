= selenium-framework

http://www.github.com/webonise
Selenium Framework is an Functional Testing Service that transparently distributes your functional tests across multiple operating systems with different versions of all major browsers AND captures a screen shot, Reports, Log. This eliminates the need to have multiple vm's on your computer or the need for multiple machines on your test to test your web application.  Running your tests remotely will dramatically speed up in-browser web testing and leave more time to  and create a slide show available to confirm visuals making it easy for you to improve your web application.

== Install

=== Ruby 1.9.3 and above

	refer installation in pages

== Using Framework

=== Generate frame

* install selenium framework gem
	gem i selenium-framework

* go to command/terminal prompt

* execute following command
	testframe new <project name>

== Configure

In configure/selenium_framework.yml you will need to define the application
* mode
* default_browser_url
* application_name
* local_browser
* browsers
* email

== Creating Tests

=== Write the testcase
   class Google
     def self.google(test_id)
       @search = "My Test Name"
       $driver.get $base_url
       $driver.find_element(:name, "q").send_keys @search
       $driver.find_element(:name, "btnK").click
     end
   end

=== Include testcases
   open the includes.rb and include the testcase file

=== Calling methods
   open the main project file call like below
   def test_google
      Google.google 1
   end

== Save the screenshot
   * include the below line wherever requiered and change the file name as you wish
   * $driver.save_screenshot($screenshot_directory_path+'/'+test_id.to_s+'-pass.png')

== Report the testcase status
   * UserExtension.write_result_to_csv($report_file, test_id, 'google search', 'PASS', '')

== Report the log
   def self.google(test_id)
    begin
     your testcase
    rescue Exception => e
         UserExtension.write_result_to_csv($report_file, test_id, 'google search', 'Fail', '')
         UserExtension.write_logs_to_text_file($log_file, e.message)
         $driver.save_screenshot($screenshot_directory_path+'/'+test_id.to_s+'-log.png')
    end

=== Using library methods

* go to irb
* require 'selenium-framework'
* UserExtension.methods
* Utility.methods
* for example using timeout error
    Utility.load_link(time) { link }

   
== Selenium Setup
* Download the latest version of selenium grid from http://seleniumhq.org/download/

===Using a Custom Selenium Server
'java --jar /path/to/your/customer/selenium-server.jar'

== Copyright

Copyright (c) 2013 Webonise Lab Pvt Ltd. See LICENSE for details.