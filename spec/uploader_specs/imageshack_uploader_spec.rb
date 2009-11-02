require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../../lib/captured/uploaders/imageshack_uploader')

describe "SCP File Uploader" do
  it "should upload to the server" do
    config = {"upload"=>{"url"=>"http://fuzzymonk.com/captured/",
      "type"=>"imageshack",
      "shackid"=>"capturedspec"}}

    @uploader = ImageshackUploader.new(config)
    @uploader.upload(File.expand_path(File.dirname(__FILE__) + '/../../resources/captured.png'))
    system "open #{@uploader.url}"
  end
end
