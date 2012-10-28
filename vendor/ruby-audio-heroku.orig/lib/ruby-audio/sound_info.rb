module RubyAudio
  # Class <code>SoundInfo</code>  provides information about open sound files'
  # format, length, samplerate, channels, and other things.
  #
  # Example:
  #   snd = RubyAudio::Sound.open("snd.wav")
  #   puts snd.info.channels                  #=> 2
  #   puts snd.info.samplerate                #=> 48000
  #   snd.close
  #
  # In addition it can be used to specify the format of new sound files:
  #
  #   info = RubyAudio::SoundInfo.new :channels => 1, :samplerate => 48000, :format => RubyAudio::FORMAT_WAV|RubyAudio::FORMAT_PCM_16
  #   snd = RubyAudio::Sound.open("new.wav", 'w', info)
  class SoundInfo < CSoundInfo
    # Creates a new SoundInfo object and populates it using the given data
    #
    # Example:
    #    info = RubyAudio::SoundInfo.new :channels => 1, :samplerate => 48000, :format => RubyAudio::FORMAT_WAV|RubyAudio::FORMAT_PCM_16
    def initialize options={}
      # Populate from options if given
      unless options.empty?
        options.each {|key,value| send("#{key}=", value)}
      end
    end

    # Returns a new <code>SoundInfo</code> object that has the same channel
    # count, sample rate, and format. This is useful in creating a new sound with
    # the same format as an already existing sound.
    #
    # Example:
    #   snd1 = RubyAudio::Sound.open("snd.wav")
    #   snd2 = RubyAudio::Sound.open("snd2.wav", 'w', snd1.info.clone)
    def clone
      SoundInfo.new(:channels => channels, :samplerate => samplerate, :format => format)
    end

    alias_method :seekable?, :seekable

    # Returns the main format constant as a string
    #
    # Example:
    #    info = RubyAudio::SoundInfo.new :channels => 1, :samplerate => 48000, :format => RubyAudio::FORMAT_WAV|RubyAudio::FORMAT_PCM_16
    #    info.main_format
    #    #=> "FORMAT_WAV"
    def main_format
      calculate_format if @main_format.nil?
      @main_format
    end

    # Returns the sub format constant as a string
    #
    # Example:
    #    info = RubyAudio::SoundInfo.new :channels => 1, :samplerate => 48000, :format => RubyAudio::FORMAT_WAV|RubyAudio::FORMAT_PCM_16
    #    info.sub_format
    #    #=> "FORMAT_PCM_16"
    def sub_format
      calculate_format if @sub_format.nil?
      @sub_format
    end

    # Returns the length of the audio file in seconds
    def length
      frames / samplerate.to_f
    end

    private
    def calculate_format
      RubyAudio.constants.grep(/FORMAT_/).map(&:to_s).each do |f|
        next if f.include?('MASK') # Skip mask constants

        val = RubyAudio.const_get(f)
        if val > RubyAudio::FORMAT_SUBMASK
          # Main format
          @main_format = f if format & RubyAudio::FORMAT_TYPEMASK == val
        else
          # Sub format
          @sub_format = f if format & RubyAudio::FORMAT_SUBMASK == val
        end
      end
    end
  end
end