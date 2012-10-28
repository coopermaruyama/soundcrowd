begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end
require 'spec/autorun'

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'ruby-audio'

def fixture file_name
  File.join(File.dirname(__FILE__), 'data', file_name)
end

def io_fixture file_name=nil
  if file_name
    path = fixture(file_name)
    StringIO.new(File.read(path))
  else
    StringIO.new
  end
end