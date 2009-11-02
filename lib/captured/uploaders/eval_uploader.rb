class EvalUploader
  attr_accessor :url

  def initialize(config = {})
    @config = config
  end

  def gen_remote_name(file)
    Digest::MD5.hexdigest(file+Time.now.to_i.to_s) + File.extname(file)
  end

  def upload(file)
    remote_path = nil
    remote_name = gen_remote_name(file)
    unless eval @config['upload']['command']
      raise "Upload failed: Bad Eval in config file"
    end
    # if the eval defines remote_path we will copy that to the clipboard
    # otherwise we compute it ouselves
    @url = remote_path || "#{@config['upload']['url']}#{remote_name}"
    @url
  end
end
