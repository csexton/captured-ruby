require 'digest/md5'
require 'erb'
require 'yaml'

class FileUploader
  def self.upload(file, options)
    self.new(options).process_upload(file)
  end

  def initialize(options)
    @growl_path = options[:growl_path] || "#{File.dirname(File.expand_path(__FILE__))}/../../resources/growlnotify"
    @config = YAML.load_file(options[:config_file])
    case @config['upload']['type']
    when "eval"
      require File.expand_path(File.dirname(__FILE__) + '/uploaders/eval_uploader')
      @uploader = EvalUploader.new(@config)
    when "scp"
      require File.expand_path(File.dirname(__FILE__) + '/uploaders/scp_uploader')
      @uploader = ScpUploader.new(@config)
    when "imgur"
      require File.expand_path(File.dirname(__FILE__) + '/uploaders/imgur_uploader')
      @uploader = ImgurUploader.new
    when "imageshack"
      require File.expand_path(File.dirname(__FILE__) + '/uploaders/imageshack_uploader')
      @uploader = ImageshackUploader.new(@config)
    else
      raise "Invalid Type"
    end
  rescue
    growl "Unable to load config file"
    raise "Unable to load config file"
  end

  def pbcopy(str)
    system "ruby -e \"print '#{str}'\" | pbcopy"
    # I prefer the following method but it was being intermitant about actually
    # coping to the clipboard.
    #IO.popen('pbcopy','w+') do |pbc|
    #  pbc.print str
    #end
  rescue
    raise "Copy to clipboard failed"
  end

  def process_upload(file)
    remote_name = Digest::MD5.hexdigest(file+Time.now.to_i.to_s) +  File.extname(file)
    growl("Processing Upload", "#{File.dirname(File.expand_path(__FILE__))}/../../resources/action_run.png")
    @uploader.upload(file)
    remote_path = @uploader.url
    puts "Uploaded '#{file}' to '#{remote_path}'"
    pbcopy remote_path
    growl("Upload Succeeded", "#{File.dirname(File.expand_path(__FILE__))}/../../resources/green_check.png")
    History.append(file, remote_path)
  rescue => e
    puts e
    puts e.backtrace
    growl(e)
  end

  def growl(msg, image = "#{File.dirname(File.expand_path(__FILE__))}/../../resources/red_x.png")
    puts "grr: #{msg}"
    if File.exists? @growl_path
      raise "Growl Failed" unless system("#{@growl_path} -t 'Captured' -m '#{msg}' --image '#{image}'")
    end
  rescue
    puts "Growl Notify Error"
  end
end
