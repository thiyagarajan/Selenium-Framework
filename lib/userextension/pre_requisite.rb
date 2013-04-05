class PreRequisite
  private
  def self.create_dir_inside_build(dirname, directory_path)
    Dir.chdir(directory_path)
    unless  (File.exists?(dirname))
      Dir.mkdir(dirname)
    end
    Dir.chdir(directory_path + '/' + dirname)
    unless  (File.exists?('.gitignore'))
      FileUtils.touch '.gitignore'
    end
    Dir.chdir(directory_path)
  end

  public
  def self.create_build_structure(store_path)
    build_path = store_path + "/builds/"
    Dir.chdir(build_path)
    if Dir.entries(build_path).size == 2
      build_number = "0"
      Dir.mkdir(build_number)
    else
      dir_list_new = []
      dir_list = Dir.entries(build_path)
      dir_list.delete(".")
      dir_list.delete("..")
      dir_list.map {|a| dir_list_new.push(a.to_i) }
      build_number = dir_list_new.max + 1
      build_number = build_number.to_s
      Dir.mkdir(build_number)
    end
    Dir.chdir(build_number)
    build_number_path = build_path + build_number + "/"
    build_internal_dir = ['screenshots','logs','reports']
    for dir_counter in 0..build_internal_dir.length-1
      create_dir_inside_build(build_internal_dir[dir_counter], build_number_path)
    end
    Dir.chdir(store_path)
    return build_number_path
  end

  def self.create_screenshot_directory_path(store_path, build_number_path)
    Dir.chdir(build_number_path + "screenshots/")
    FileUtils.touch ".gitignore"
    screenshot_path = build_number_path + "screenshots/"
    Dir.chdir(store_path)
    return screenshot_path
  end

  def self.create_report_file(store_path, build_number_path)
    Dir.chdir(build_number_path + "reports/")
    report_file = build_number_path + "reports/" + "report.csv"
    FileUtils.touch(report_file)
    CSV.open(report_file, "wb") do |csv_file|
      csv_file << ["BROWSER", "TEST_ID", "TEST_CASE", "RESULT"]
    end
    Dir.chdir(store_path)
    return report_file
  end

  def self.create_log_file(store_path, build_number_path)
    Dir.chdir(build_number_path + "logs/")
    log_file = build_number_path + "logs/" + "execution.log"
    FileUtils.touch(log_file)
    File.open(log_file, "wb") do |txt_file|
      txt_file.puts "LOGS WITH RESULTS"
    end
    Dir.chdir(store_path)
    return log_file
  end

end