require 'digest/md5'
require 'erb'

GROWL_BIN = "/usr/local/bin/growlnotify"

class FileUploader
  def self.upload(file)
    self.new.process_upload(file)
  end

  def initialize(config = YAML.load_file(Captured.config_file))
    case config['upload']['type']
    when"eval"
      @upload_command = config['upload']['command']
    when"scp"
    when"ftp"
    else
      raise "Invalid Type"
    end
  end

  def process_upload(file)
    remote_name = Digest::MD5.hexdigest(file+Time.now.to_i.to_s) +  File.extname(file)
    if eval @upload_command
      puts "Uploaded '#{file}' to '#{remote_name}'"
      raise "Copy Failed" unless system("echo 'http://fuzzymonk.com/captured/#{remote_name}' | pbcopy")
      growl("Uploaded Image", file)
    else 
      raise "Upload Failed: Bad Eval"
    end
  rescue => e 
    puts e
    growl(e)
  end

  def growl(msg, image = "#{File.dirname(File.expand_path(__FILE__))}/../../resources/red_x.png")
      raise "Growl Failed" unless system("#{GROWL_BIN} -t 'Captured' -m '#{msg}' --image '#{image}'")
  end
end
