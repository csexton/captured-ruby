class FileTracker
  attr_accessor :tracked_files

  def initialize
    @tracked_files = {}
  end

  def scan(paths, state)
    puts "Scannign #{paths}"
    paths.each do |path|
      Dir["#{path}Screenshot**.png"].each do |file|
        self.add file, state
      end
    end
  end

  def add(file, state)
    unless @tracked_files[file]
      puts "Adding #{file} to tracked files as #{state}"
      @tracked_files[file] = state
    end
  end

  def mark_processed(file)
    puts "Marking #{file} processed"
    @tracked_files[file] = :processed
  end

  def each_pending
    @tracked_files.each_pair do |key, value|
      if(value == :pending)
        yield(key)
      end
    end
  end
end
