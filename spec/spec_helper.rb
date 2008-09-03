begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'smallduration'

require 'pathname'
require 'yaml'

def fixture_path
  Pathname.new(File.dirname(__FILE__)) + 'fixtures'
end

def yaml_fixture(basename)
  YAML::load_file(fixture_path + "#{basename}.yml")
end

def yaml(path)
  YAML::load_file path
end

Spec::Runner.configure do |config|
end
