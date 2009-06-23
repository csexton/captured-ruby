
require 'captured/file_tracker'
require 'captured/file_uploader'
require 'captured/fs_events'


class Captured
  def self.run!
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
