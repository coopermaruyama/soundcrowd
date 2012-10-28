module RubyAudio
  # The <code>Buffer</code> class contains sound data read out of the sound. It
  # can store a fixed maximum number of multi-channel audio frames of a specifi
  # data type. Valid types are <code>short</code>, <code>int</code>,
  # <code>float</code>, and <code>double</code>. The channel count must match up
  # to the channel count of the sounds being read and written to. Trying to read
  # into a buffer with the wrong number of channels will result in an error.
  #
  # Example:
  #   buf = RubyAudio::Buffer.float(1000)
  #   buf = RubyAudio::Buffer.new("float", 1000, 1)
  class Buffer < CBuffer
    [:short, :int, :float, :double].each do |type|
      eval "def self.#{type}(frames, channels=1); self.new(:#{type}, frames, channels); end"
    end
  end
end
