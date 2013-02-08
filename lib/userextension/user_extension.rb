class UserExtension

  # Call this function this way "generateRandomYopmailId(rand(8..20))".
  # This function will generate a random Yopmail id and return it.
  def self.generate_mail_id(length, domain)
    yopmailid = (1..length).map { ('a'..'z').to_a[rand(26)] }.join+"@"+domain.to_s
    return yopmailid
  end

  # Call this function this way "generateRandomString(rand(5..20))".
  # This function will generate a random string and return it.
  def self.generate_string(length)
    str = (1..length).map { ('a'..'z').to_a[rand(26)] }.join
    return str
  end

  # Call this function this way "generateTitle".
  # This function will generate a title and return it.
  def self.generate_title
    title = Faker::Name.prefix
    return title
  end

  # Call this function this way "generateRandomName(rand(5..20))".
  # This function will generate a random name and return it.
  def self.generate_name(length)
    str = (1..length-1).map { ('a'..'z').to_a[rand(26)] }.join
    str = ('A'..'Z').to_a[rand(26)] + str
    #str = Faker::Name.first_name
    #while str.length != length
    #  str = Faker::Name.first_name
    #end
    str.capitalize
    return str
  end

  # Call this function this way "generateRandomNumber(1,10)".
  # This function will generate a random number and return it.
  def self.generate_number(minrange, maxrange)
    number = rand(minrange..maxrange)
    return number
  end

  # Call this function this way "generateFutureDate(40)".
  # This function will generate a future date and return it.
  def self.generate_future_date(days)
    date = Date.strptime(Date.today.to_s)
    date = date + days
    return date.strftime("%d-%m-%Y")
  end

  # Call this function this way "generatePastDate(40)".
  # This function will generate a past date and return it.
  def self.generate_past_date(days)
    date = Date.strptime(Date.today.to_s)
    date = date - days
    return date.strftime("%d-%m-%Y")
  end

  # Call this function this way "generateAlphaNumericString(rand(5..20))".
  # This function will generate a random alpha-numeric string and return it.
  def self.generate_alphanumeric_string(length)
    str = (1..length).map { rand(36).to_s(36) }.join
    return str
  end

  # Call this function this way "generateStreetAddress".
  # This function will generate a random street address and return it.
  def self.generate_street_address
    street_address = Faker::Address.street_address
    return street_address
  end

  # Call this function this way "generateAddress".
  # This function will generate a random address and return it.
  def self.generate_address
    address = Faker::Address.secondary_address
    return address
  end

  # Call this function this way "generatePhoneNumber".
  # This function will generate a random phone number and return it.
  def self.generate_phone_number
    phone_number = rand(1000000000..9999999999)
    return phone_number
  end

  # Call this function this way "genarateParagraph".
  # This function will generate a paragraph and return it.
  def self.genarate_paragraph
    paragraph = Faker::Lorem.paragraphs.map { |i| i.to_s }.join(" ")
    return paragraph
  end

  # Call this function this way "genarateWords(3)".
  # This function will generate words and return it.
  def self.genarate_words(number)
    words = Faker::Lorem.words(number).map { |i| i.to_s }.join(" ")
    return words
  end

  # Call this function this way "genarateSentence".
  # This function will generate a sentence and return it.
  def self.genarate_sentence
    sentence = Faker::Lorem.sentence
    return sentence
  end

  # Call this function this way "writeResultToCSV(report_file,test_id,test_case,result,comment="")".
  # This function will write the result to .csv file.
  def self.write_result_to_csv(report_file, test_id, test_case, result, comment="")
    CSV.open(report_file, "ab") do |csv_file|
      csv_file << [test_id, test_case, result, comment]
    end
  end

  # Call this function this way "writeLogstoTextFile(log_file,logs)".
  # This function will write the logs to .log file.
  def self.write_logs_to_text_file(log_file, logs)
    File.open(log_file, "a") do |txt_file|
      txt_file.puts logs
      txt_file.puts "\n"
    end
  end

  # Call this function this way "element_present?(how, what)".
  # This function will check if the element is present or not.
  def self.element_present?(how, what)
    begin
      $driver.find_element(how, what)
      return true
    rescue
      return false
    end
  end

  # Call this function this way "preRequisite(build_no,browser,timestamp)".
  # This function will create the pre-requisites for the project.
  def self.pre_requisite(build_no, browser, timestamp)
    returning_array = Array.new
    build_no = build_no.to_s
    browser = browser.to_s
    timestamp = timestamp.to_s
    store_path = Dir.pwd
    Dir.chdir("screenshots")
    Dir.mkdir(build_no)
    Dir.chdir(build_no)
    Dir.mkdir(browser +"_"+ timestamp)
    Dir.chdir(browser +"_"+ timestamp)
    screenshot_path = store_path + "/screenshots/" + build_no + "/" + browser +"_"+ timestamp + "/"
    returning_array.push(screenshot_path)
    Dir.chdir(store_path)

    Dir.chdir("reports")
    Dir.mkdir(build_no)
    report_path = store_path + "/reports/" + build_no + "/"
    Dir.chdir(report_path)
    report_file = report_path + build_no +"_" + browser +"_"+ timestamp + ".csv"
    FileUtils.touch(report_file)
    CSV.open(report_file, "wb") do |csv_file|
      csv_file << ["TEST_ID", "TEST_CASE", "RESULT", "COMMENTS"]
    end
    returning_array.push(report_file)
    broken_links_report_file = report_path + build_no +"_broken_links_" + timestamp + ".csv"
    FileUtils.touch(broken_links_report_file)
    CSV.open(broken_links_report_file, "wb") do |csv_file|
      csv_file << ["LINK", "RESPONSE", "COMMENTS"]
    end
    returning_array.push(broken_links_report_file)
    Dir.chdir(store_path)

    Dir.chdir("logs")
    Dir.mkdir(build_no)
    log_path = store_path + "/logs/" + build_no + "/"
    Dir.chdir(log_path)
    log_file = log_path + build_no +"_" + browser + "_" + timestamp + ".log"
    FileUtils.touch(log_file)
    File.open(log_file, "wb") do |txt_file|
      txt_file.puts "LOGS WITH RESULTS"
    end
    returning_array.push(log_file)
    Dir.chdir(store_path)

    return returning_array
  end


  def self.init_record()
    os = RUBY_PLATFORM
    if os.include? "linux"
      headless_obj = Headless.new
      headless_obj.start
      return headless_obj
    else
      puts "#{RUBY_PLATFORM} is not a linux platform !!!"
    end
  end


  def self.record_video_start_capture(headless_obj)
    os = RUBY_PLATFORM
    if os.include? "linux"
      headless_obj.video.start_capture
    else
      puts "#{RUBY_PLATFORM} is not a linux platform !!!"
    end
  end


  def self.record_video_stop_and_save(headless_obj,filename)
    os = RUBY_PLATFORM
    if os.include? "linux"
      headless_obj.video.stop_and_save(filename)
    else
      puts "#{RUBY_PLATFORM} is not a linux platform !!!"
    end
  end


  def self.record_video_stop_and_discard(headless_obj)
    os = RUBY_PLATFORM
    if os.include? "linux"
      headless_obj.video.stop_and_discard()
    else
      puts "#{RUBY_PLATFORM} is not a linux platform !!!"
    end
  end


  def self.capture_screenshot(selenium_diver,filename)
    browser_name = selenium_diver.capabilities.browser_name
    unless (browser_name.include? "safari")
      selenium_diver.save_screenshot filename
    else
      puts "#{browser_name} does not support for capturing screenshot !!!"
    end
  end

end
