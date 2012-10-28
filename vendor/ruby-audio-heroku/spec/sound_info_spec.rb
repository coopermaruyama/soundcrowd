require "spec_helper.rb"

describe RubyAudio::SoundInfo do
  it "should initialize with default properties" do
    info = RubyAudio::SoundInfo.new
    info.channels.should == 0
    info.samplerate.should == 0
    info.format.should == 0
  end

  it "should allow setting properties on initialize" do
    info = RubyAudio::SoundInfo.new(:channels => 1, :samplerate => 48000, :format => RubyAudio::FORMAT_WAV|RubyAudio::FORMAT_PCM_16)
    info.channels.should == 1
    info.samplerate.should == 48000
    info.format.should == RubyAudio::FORMAT_WAV|RubyAudio::FORMAT_PCM_16
  end

  it "should allow setting properties after initialize" do
    info = RubyAudio::SoundInfo.new
    info.channels = 3
    info.channels.should == 3
  end

  it "should not be valid if properties invalid" do
    info = RubyAudio::SoundInfo.new(:channels => 1, :samplerate => 48000, :format => RubyAudio::FORMAT_WAV)
    info.valid?.should == false
    info.format = RubyAudio::FORMAT_WAV|RubyAudio::FORMAT_PCM_16
    info.valid?.should == true
  end

  it "should allow cloning" do
    info = RubyAudio::SoundInfo.new(:channels => 1, :samplerate => 48000, :format => RubyAudio::FORMAT_WAV|RubyAudio::FORMAT_PCM_16)
    info2 = info.clone
    info.object_id.should_not == info2.object_id
    info.channels.should == info2.channels
    info.samplerate.should == info2.samplerate
    info.format.should == info2.format
  end

  it "should calculate main and sub format from format" do
    info = RubyAudio::SoundInfo.new(:format => RubyAudio::FORMAT_WAV|RubyAudio::FORMAT_PCM_16)
    info.main_format.should == "FORMAT_WAV"
    info.sub_format.should == "FORMAT_PCM_16"

    info = RubyAudio::SoundInfo.new(:format => RubyAudio::FORMAT_WAVEX|RubyAudio::FORMAT_MS_ADPCM)
    info.main_format.should == "FORMAT_WAVEX"
    info.sub_format.should == "FORMAT_MS_ADPCM"
  end

  it "should return the length of an audio file" do
    RubyAudio::Sound.open(fixture('what.wav')) do |snd|
      snd.info.length.should == 26413 / 16000.0
    end
  end
end