require 'rubygems'
require 'spec'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'captured'

CONFIG = YAML.load_file("#{ENV['HOME']}/.captured.yml")

Spec::Runner.configure do |config|
  
end
