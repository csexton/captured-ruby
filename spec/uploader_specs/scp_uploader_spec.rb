require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../../lib/captured/uploaders/scp_uploader')

describe "SCP File Uploader" do
  before(:all) do
  end

  it "should upload to the server" do
    # This spec requires a scp_spec section in the config file with the
    # scp settings
    config = YAML.load_file("#{ENV['HOME']}/.captured.yml")['scp_spec']

    @uploader = ScpUploader.new(config)
    @uploader.upload(File.expand_path(File.dirname(__FILE__) + '/../../resources/captured.png'))
    system "open #{@uploader.url}"
  end
end
