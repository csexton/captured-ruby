require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../../lib/captured/uploaders/imgur_uploader')

if CONFIG['imgur_spec']
  describe "Imgur File Uploader" do
    it "should upload to the server" do
      # This spec requires a scp_spec section in the config file with the
      # scp settings
      config = CONFIG['imgur_spec']
      @uploader = ImgurUploader.new
      @uploader.upload(File.expand_path(File.dirname(__FILE__) + '/../../resources/captured.png'))
      system "open #{@uploader.url}"
    end
  end
end
