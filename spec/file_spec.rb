RSpec.describe PL2USB::Track do
  context "missing" do
    file = PL2USB::File.new(::File.join(::File.dirname(__FILE__), "test_files/missing.mp3"), "mp3")

    it "should know the path" do
      expect(file.path).to eql ::File.join(::File.dirname(__FILE__), "test_files/missing.mp3")
    end

    it "should not exist" do
      expect(file.exist?).to be false
    end

    it "should have nil length" do
      expect(file.length).to be_nil
    end

    it "should have extension" do
      expect(file.extension).to eql "mp3"
    end

    it "should not be lossless" do
      expect(file.lossless?).to be false
    end

    it "should have nil size" do
      expect(file.size).to be nil
    end

    it "should have correct kind" do
      expect(file.kind).to eql "mp3"
    end

    it "should have nil bitrate" do
      expect(file.bitrate).to be nil
    end
  end

  context "test1" do
    file = PL2USB::File.new(::File.join(::File.dirname(__FILE__), "test_files/test1.mp3"), "mp3")

    it "should know the path" do
      expect(file.path).to eql ::File.join(::File.dirname(__FILE__), "test_files/test1.mp3")
    end

    it "should exist" do
      expect(file.exist?).to be true
    end

    it "should have correct length" do
      expect(file.length).to eql 12
    end

    it "should have extension" do
      expect(file.extension).to eql "mp3"
    end

    it "should not be lossless" do
      expect(file.lossless?).to be false
    end

    it "should have correct size" do
      expect(file.size).to eql 199850
    end

    it "should have correct kind" do
      expect(file.kind).to eql "mp3"
    end

    it "should have correct bitrate" do
      expect(file.bitrate).to eql 128
    end
  end

  context "test2" do
    file = PL2USB::File.new(::File.join(::File.dirname(__FILE__), "test_files/test2.m4a"), "alac")

    it "should be lossless" do
      expect(file.lossless?).to be true
    end

    it "should have correct kind" do
      expect(file.kind).to eql "alac"
    end

    it "should have correct bitrate" do
      expect(file.bitrate).to eql 702
    end
  end

  context "test3" do
    file = PL2USB::File.new(::File.join(::File.dirname(__FILE__), "test_files/test3.m4a"), "aac")

    it "should not be lossless" do
      expect(file.lossless?).to be false
    end

    it "should have correct kind" do
      expect(file.kind).to eql "aac"
    end

    ## NOTE: AudioInfo doesn't get a bitrate for some reason.
    #it "should have correct bitrate" do
    #  expect(file.bitrate).to eql nil
    #end
  end
end
