module RubyAudio
  # Class <code>Sound</code> wraps libsndfile to provide simple reading and
  # writing for a wide variety of file formats
  #
  # Reading Example:
  #   RubyAudio::Sound.open('sound.wav') do |snd|
  #     buf = snd.read(:float, 100)
  #     puts buf.real_size                         #=> 100
  #   end
  #
  # Writing Example:
  #   buf = RubyAudio::Buffer.float(1000)
  #   out = nil
  #   ['snd1.wav', 'snd2.wav', 'snd3.wav'].each do |file|
  #     RubyAudio::Sound.open(file) do |snd|
  #       out = RubyAudio::Sound.open('out.wav', 'w', snd.info.clone) if out.nil?
  #
  #       while snd.read(buf) != 0
  #         out.write(buf)
  #       end
  #     end
  #   end
  #   out.close if out
  class Sound < CSound
    # Creates a new <code>Sound</code> object for the audio file at the given path.
    # Mode defaults to <code>"r"</code>, but valid modes are <code>"r"</code>,
    # <code>"w"</code>, and <code>"rw"</code>.
    #
    # When creating a new sound, a valid <code>SoundInfo</code> object must be
    # passed in, as libsndfile uses it to determine the output format.
    #   info = RubyAudio::SoundInfo.new :channels => 1, :samplerate => 48000, :format => RubyAudio::FORMAT_WAV|RubyAudio::FORMAT_PCM_16
    #   snd = RubyAudio::Sound.new "new.wav", 'r', info
    def initialize(path, mode='r', info=nil)
      info ||= SoundInfo.new
      super(path, mode, info)
    end

    # Seeks to a given offset <i>anInteger</i> in the sound according to the value
    # of <i>whence</i>:
    #
    #   IO::SEEK_CUR  | Seeks to _frames_ plus current position
    #   --------------+----------------------------------------------------
    #   IO::SEEK_END  | Seeks to _frames_ plus end of stream (you probably
    #                 | want a negative value for _frames_)
    #   --------------+----------------------------------------------------
    #   IO::SEEK_SET  | Seeks to the absolute location given by _frames_
    def seek(frames, whence=IO::SEEK_SET)
      super(frames, whence)
    end

    # Reads a given number of frames from the sound into a buffer
    #
    # When given a buffer as the first argument, it reads data into that buffer
    # reading an optional number of frames as the second argument. It returns
    # the number of frames read.
    #
    # Example:
    #   buf = RubyAudio::Buffer.float(1000)
    #   snd.read(buf)                        #=> 1000
    #   snd.read(buf, 50)                    #=> 50
    #
    # When given a string or symbol as the first argument, it interprets this as
    # the data type and creates a new buffer of the given size to read the data
    # into. The buffer is correctly initialized with the proper number of channels
    # to hold data from that sound.
    #
    # Example:
    #   buf = snd.read("int", 1000)
    def read(*args)
      case args[0]
      when Buffer
        buf = args[0]
        size = args[1] || buf.size
        return super(buf, size)
      when Symbol, String
        type = args[0]
        buf = Buffer.new(type, args[1], info.channels)
        super(buf, buf.size)
        return buf
      else
        raise ArgumentError, "invalid arguments"
      end
    end
  end
end