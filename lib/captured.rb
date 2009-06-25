
require 'captured/file_tracker'
require 'captured/file_uploader'
require 'captured/fs_events'

class Captured
  def self.config_file
    "#{ENV['HOME']}/.captured.yml" 
  end

  def self.run_once!
    desktop_dir = "#{ENV['HOME']}/Desktop/"
    Dir["#{desktop_dir}Screenshot**.png"].each do |file|
      if (File.mtime(file).to_i > (Time.now.to_i-10))
        puts "#{file} is new"
        FileUploader.upload(file)
      end
    end
  end

  def self.run_and_watch!
    desktop_dir = "#{ENV['HOME']}/Desktop/"
    tracker = FileTracker.new
    tracker.scan([desktop_dir], :existing)
    e = FSEvents.new(desktop_dir)
    e.run do |paths|
      tracker.scan paths, :pending
      tracker.each_pending do |file|
        FileUploader.upload(file)
        tracker.mark_processed(file)
      end
    end
  end
end
