begin
  # Fat binaries for Windows
  RUBY_VERSION =~ /(\d+.\d+)/
  require "#{$1}/rubyaudio_ext"
rescue LoadError
  require "rubyaudio_ext"
end
require 'ruby-audio/buffer'
require 'ruby-audio/sound_info'
require 'ruby-audio/sound'