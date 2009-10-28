require 'digest/md5'
require 'erb'
require 'yaml'

class FileUploader
  def self.upload(file, options)
    self.new(options).process_upload(file)
  end

  def initialize(options)
    @growl_path = options[:growl_path] || "/usr/local/bin/growlnotify"
    @config = YAML.load_file(options[:config_file])
    case @config['upload']['type']
    when"eval"
      @upload_proc = eval_proc
    when"scp"
      @upload_proc = scp_proc
    when"ftp"
    else
      raise "Invalid Type"
    end
  end

  def eval_proc
    lambda do |file, remote_name|
      remote_path = nil
      unless eval @config['upload']['command']
        raise "Upload failed: Bad Eval in config file"
      end
      # if the eval defines remote_path we will copy that to the clipboard
      # otherwise we compute it ouselves
      remote_path || "#{@config['upload']['url']}#{remote_name}"
    end
  end

  def scp_proc
    require 'net/scp'
    require 'etc'
    settings = @config['upload']
    lambda do |file, remote_name|
      Net::SCP.upload!(settings['host'],
                       settings['user'] || Etc.getlogin,
                       file,
                       settings['path']+remote_name,
                       :password => settings['password'])

      "#{@config['upload']['url']}#{remote_name}"
    end
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
    remote_path = @upload_proc.call(file, remote_name)
    puts "Uploaded '#{file}' to '#{remote_path}'"
    pbcopy remote_path
    growl("Upload Succeeded", "#{File.dirname(File.expand_path(__FILE__))}/../../resources/green_check.png")
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
  end
end
