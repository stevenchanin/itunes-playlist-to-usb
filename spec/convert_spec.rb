require File.join(File.dirname(__FILE__), "../lib/itunes-playlist-to-usb")
TEST_DIR = File.join(File.dirname(__FILE__), "./test_files")
SETTINGS = YAML.load_file(File.join(File.dirname(__FILE__), "./test_settings.yml"))

RSpec.describe Convert, "#mp3" do
  context "with an mp3 file" do
    mp3 = Convert.new(File.join(TEST_DIR, "test1.mp3"))

    it "is encoded as mp3" do
      expect(mp3.encoding).to eq "mp3"
    end

    it "is not lossless" do
      expect(mp3.lossless).to be false
    end

    it "it has correct output file" do
      expect(File.basename(mp3.file_out)).to eql "test1.mp3"
    end

    it "it should not be converted" do
      expect(mp3.convert?).to be false
    end
  end

  context "with an alac file" do
    alac = Convert.new(File.join(TEST_DIR, "test2.m4a"))

    it "is encoded as alac" do
      expect(alac.encoding).to eq "alac"
    end

    it "is is lossless" do
      expect(alac.lossless).to be true
    end

    it "it has correct output file" do
      expect(File.basename(alac.file_out)).to eql "test2.mp3"
    end

    it "it should be converted" do
      expect(alac.convert?).to be true
    end
  end
end
