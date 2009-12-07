require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "File Uploader" do
  before(:all) do
    # This is run once and only once, before all of the examples

    #Make a backup of the clipboard
    $pb_backup = `pbpaste`

    system "mkdir -p #{File.dirname(__FILE__) + '/../tmp/watch_path'}"
    @options = {:config_file => File.dirname(__FILE__) + '/fixtures/scp_config.yml',
      :watch_path => File.dirname(__FILE__) + '/../tmp/watch_path',
      :watch_pattern => Captured.guess_watch_path,
      :growl_path => "#{File.dirname(File.expand_path(__FILE__))}/../resources/growlnotify" }
  end

  after(:all) do
    # This is run once and only once, after all of the examples
    # Restore the clipboard contents
    FileUploader.new(@options).pbcopy $pb_backup
  end


  it "should copy text to the system clipboard" do
    fu = FileUploader.new @options
    str = "Testing captured is fun for you"
    fu.pbcopy str
    `pbpaste`.should == str
  end
end
