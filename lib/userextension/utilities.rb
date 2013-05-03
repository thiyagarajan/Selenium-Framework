class Utility

  def self.zip(dir, zip_dir, remove_after = false)
    Zip::ZipFile.open(zip_dir, Zip::ZipFile::CREATE) do |zipfile|
      Find.find(dir) do |path|
        Find.prune if File.basename(path)[0] == ?.
        dest = /#{dir}\/(\w.*)/.match(path)
        # Skip files if they exists
        begin
          zipfile.add(dest[1], path) if dest
        rescue Zip::ZipEntryExistsError
        end
      end
    end
    FileUtils.rm_rf(dir) if remove_after
  end

  def self.email(email_id, build_zip)
    Mail.defaults do
      delivery_method :smtp, {:address => 'smtp.sendgrid.net',
                              :port => 587,
                              :domain => 'vtr.com',
                              :user_name => 'locamotiv',
                              :password => 'locamotiv',
                              :authentication => 'plain',
                              :enable_starttls_auto => true}
    end

    mail = Mail.new do
      to [email_id.to_s]
      from 'vtr@weboniselab.com'
      subject Time.now.to_s + 'Test - Automation Script Result'

      html_part do
        content_type 'text/html; charset=UTF-8'
        body '<b>Script Result</b>'
      end
      add_file build_zip
    end
    mail.deliver!
  end

end