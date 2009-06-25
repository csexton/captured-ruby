class FSEvents
  def initialize(dir = "#{HOME}/Desktop")
    @watch_dir = dir
  end

  def run
    require 'osx/foundation'
    OSX.require_framework '/System/Library/Frameworks/CoreServices.framework/Frameworks/CarbonCore.framework'

    callback = proc do |stream, ctx, numEvents, paths, marks, eventIDs|

      #p stream
      #p ctx
      #p numEvents
      #p paths.methods
      #p marks.methods
      #p eventIDs

      paths.regard_as('*')
      rpaths = []
      numEvents.times { |i| rpaths << paths[i] }

      yield(*rpaths)
    end

    allocator = OSX::KCFAllocatorDefault
    context   = nil
    path      = [@watch_dir] #[Dir.pwd]
    sinceWhen = OSX::KFSEventStreamEventIdSinceNow
    latency   = 1.0
    flags     = 0

    stream   = OSX::FSEventStreamCreate(allocator, callback, context, path, sinceWhen, latency, flags)
    unless stream
      puts "Failed to create stream"
      exit
    end

    OSX::FSEventStreamScheduleWithRunLoop(stream, OSX::CFRunLoopGetCurrent(), OSX::KCFRunLoopDefaultMode)
    unless OSX::FSEventStreamStart(stream)
      puts "Failed to start stream"
      exit
    end

    puts "Watching #{path}"

    OSX::CFRunLoopRun()
  rescue Interrupt
    OSX::FSEventStreamStop(stream)
    OSX::FSEventStreamInvalidate(stream)
    OSX::FSEventStreamRelease(stream)
  end

end
