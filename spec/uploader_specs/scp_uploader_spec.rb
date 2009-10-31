require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../../lib/captured/uploaders/scp_uploader')

describe "SCP File Uploader" do
  before(:all) do
  end

  it "should upload to the server" do
    config = {"upload"=>{"url"=>"http://fuzzymonk.com/captured/", 
      "type"=>"scp",
      "path"=>"",
      "host"=>""}}
      "user"=>""}}

    @uploader = ScpUploader.new(config)
    @uploader.upload(File.expand_path(File.dirname(__FILE__) + '/../../resources/captured.png'))
    system "open #{@uploader.url}"
  end
end
