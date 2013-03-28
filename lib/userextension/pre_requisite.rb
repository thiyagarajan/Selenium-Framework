class PreRequisite

  def self.create_screenshot_directory_path(store_path, build_no, browser, timestamp)
    build_no = build_no.to_s
    browser = browser.to_s
    timestamp = timestamp.to_s
    Dir.chdir(store_path +"/screenshots/")
    Dir.mkdir(build_no)
    Dir.chdir(build_no)
    Dir.mkdir(browser +"_"+ timestamp)
    Dir.chdir(browser +"_"+ timestamp)
    FileUtils.touch ".gitignore"
    screenshot_path = store_path + "/screenshots/" + build_no + "/" + browser +"_"+ timestamp + "/"
    Dir.chdir(store_path)
    return screenshot_path
  end

  def self.create_report_file(store_path, build_no, browser, timestamp)
    build_no = build_no.to_s
    browser = browser.to_s
    timestamp = timestamp.to_s
    Dir.chdir(store_path +"/reports/")
    Dir.mkdir(build_no)
    report_path = store_path + "/reports/" + build_no + "/"
    Dir.chdir(report_path)
    report_file = report_path + build_no +"_" + browser +"_"+ timestamp + ".csv"
    FileUtils.touch(report_file)
    CSV.open(report_file, "wb") do |csv_file|
      csv_file << ["TEST_ID", "TEST_CASE", "RESULT", "COMMENTS"]
    end
    Dir.chdir(store_path)
    return report_file
  end

  def self.create_log_file(store_path, build_no, browser, timestamp)
    build_no = build_no.to_s
    browser = browser.to_s
    timestamp = timestamp.to_s
    Dir.chdir(store_path +"/logs/")
    Dir.mkdir(build_no)
    log_path = store_path + "/logs/" + build_no + "/"
    Dir.chdir(log_path)
    log_file = log_path + build_no +"_" + browser + "_" + timestamp + ".log"
    FileUtils.touch(log_file)
    File.open(log_file, "wb") do |txt_file|
      txt_file.puts "LOGS WITH RESULTS"
    end
    Dir.chdir(store_path)
    return log_file
  end

end