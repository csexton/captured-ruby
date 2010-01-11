require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "History" do
  before(:each) do
    @date_time = mock(DateTime)
    @date_time.stub!(:strftime).and_return("01/11/2010 02:48PM")
    DateTime.stub!(:now).and_return(@date_time)
    History.stub!(:file_path).and_return("#{File.dirname(__FILE__)}/fixtures/history")
  end

  it "should format a line" do
    line = History.format_line("original_name", "remote_path")
    line.should == "01/11/2010 02:48PM original_name remote_path"
  end

  it "should list the history" do
    History.should respond_to(:list)
  end
end

