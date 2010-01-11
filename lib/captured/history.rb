require 'shellwords'

class History

  def self.file_path
    "#{ENV['HOME']}/.captured_history"
  end

  def self.time_stamp
    DateTime.now.strftime("%m/%d/%Y-%I:%M%p")
  end

  def self.append(original_name, remote_path)
    File.open(History.file_path, 'a') do |f|
      f.puts(History.format_line(original_name, remote_path))
    end
  end

  def self.format_line(original_name, remote_path)
    "#{History.time_stamp} \"#{original_name}\" #{remote_path}"
  end

  def self.list
    if File.exists? History.file_path
      File.open(History.file_path).each do |line|
        puts line
      end
    else
      puts "You ain't got no history yet"
    end
  end
end
