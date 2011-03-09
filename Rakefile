require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "captured"
    gem.summary = "Quick screenshot sharing for OS X"
    gem.description = "Because <shift>-<command>-4 is the single most useful shorcut in Macdom"
    gem.email = "csexton@gmail.com"
    gem.homepage = "http://github.com/csexton/captured"
    gem.authors = ["Christopher Sexton"]
    gem.add_dependency('imgur')
    gem.add_dependency('net-scp')
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
    gem.files = FileList["VERSION", "[A-Z]*.*", "{bin,etc,lib,features,resources,spec}/**/*"]
    gem.post_install_message = <<MESSAGE

   =========================================================================

             Thanks for installing Captured! You can now run:

   captured --install      to setup launchd to run captured in the background

    When you install an example config file to ~/.captured.yml, which has a
    few examples of possible configuration types.

   =========================================================================

MESSAGE
  end

  Jeweler::GemcutterTasks.new

rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end


require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.rspec_opts = ['--colour', '--format specdoc', '--loadby mtime', '--reverse']
end

#RSpec::Core::RakeTask.new(:rcov) do |spec|
#  spec.libs << 'lib' << 'spec'
#  spec.pattern = 'spec/**/*_spec.rb'
#  spec.rcov = true
#end

desc "Release to rubyforge and gemcutter"
  task :doit => ['gemcutter:release'] do
    puts "Released"
  end


task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "captured #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

