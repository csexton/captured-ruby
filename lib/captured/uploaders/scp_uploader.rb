class ScpUploader
  attr_accessor :url

  def initialize(config = {})
    @config = config
  end

  def gen_remote_name(file)
    Digest::MD5.hexdigest(file+Time.now.to_i.to_s) +  File.extname(file)
  end

  def upload(file)
    puts "Uploading #{file}"
    # TODO: This needs to be called from file upload
    # and this calss needs to be completed
    # maybe some tests
    require 'net/scp'
    require 'etc'
    settings = @config['upload']
    remote_name = gen_remote_name(file)
    puts Net::SCP.upload!(settings['host'],
                     settings['user'] || Etc.getlogin,
                     file,
                     settings['path']+remote_name,
                     :password => settings['password'])

    @url = "#{@config['upload']['url']}#{remote_name}"
    @url
  end
end
