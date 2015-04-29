require File.join(File.dirname(__FILE__), "../lib/itunes-playlist-to-usb")
TEST_DIR = File.join(File.dirname(__FILE__), "./test_files")

RSpec.describe Convert, "#mp3" do
  it "is not lossless" do
    mp3 = Convert.new(File.join(TEST_DIR, "test1.mp3"))
    expect(mp3.lossless).to be true
  end
end
