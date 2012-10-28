require "spec_helper.rb"

describe RubyAudio::Buffer do
  it "should initialize properly" do
    buf = RubyAudio::Buffer.new('float', 100, 2)
    buf.channels.should == 2
    buf.size.should == 100
    buf.real_size.should == 0
    buf.type.should == :float
  end

  it "should support pretty typed constructors" do
    lambda {
      [:short, :int, :float, :double].each do |type|
        buf = RubyAudio::Buffer.send(type, 100)
      end
    }.should_not raise_error
  end

  it "should allow [] access on integer single channel buffers" do
    buf = RubyAudio::Buffer.int(100, 1)
    buf[0] = 1.3
    buf[0].should == 1

    buf = RubyAudio::Buffer.short(100, 1)
    buf[20] = 614
    buf[20].should == 614
  end

  it "should allow [] access on floating point single channel buffers" do
    buf = RubyAudio::Buffer.double(100, 1)
    buf[30] = 1.375
    buf[30].should == 1.375

    buf = RubyAudio::Buffer.float(100, 1)
    buf[12] = 5
    buf[12].should == 5.0
  end

  it "should allow [] access on multi-channel buffers" do
    buf = RubyAudio::Buffer.double(100, 2)
    buf[0] = [0.5, 0.3]
    buf[0].should == [0.5, 0.3]
  end

  it "should raise exception if channel count of set frame does not match buffer's" do
    lambda {
      buf = RubyAudio::Buffer.double(100, 2)
      buf[0] = [0.4, 0.8, 0.8]
    }.should raise_error(RubyAudio::Error, "array length must match channel count")
  end

  it "should return nil on out-of-bounds [] access" do
    buf = RubyAudio::Buffer.float(100)
    buf[101].should == nil
    buf[-1].should == nil
  end

  it "should truncate invalid real size" do
    buf = RubyAudio::Buffer.float(100)
    buf.real_size = 101
    buf.real_size.should == 100
  end

  it "should support cloning/duping" do
    buf = RubyAudio::Buffer.int(100)
    buf[4] = 100

    buf2 = buf.dup
    buf2.size.should == buf.size
    buf2[4].should == 100

    buf[4] = 140
    buf2[4].should == 100
  end

  context ".each" do
    before(:each) do
      @buf = RubyAudio::Buffer.int(10, 2)
      10.times do |i|
        @buf[i] = [i, i]
      end
    end

    it "should yield the elements in order" do
      i = 0
      @buf.each do |left, right|
        left.should == i
        right.should == i
        i += 1
      end
    end

    it "shouldn't do anything on an empty buffer" do
      buf = RubyAudio::Buffer.int(50, 2)

      buf.each do
        fail "This shouldn't be executed"
      end
    end

    it "should support usage through returned enumerable" do
      enum = @buf.each
      enum.any? {|frame| frame[0] == 5}.should == true
    end
  end
end
