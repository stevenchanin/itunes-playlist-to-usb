RSpec.describe PL2USB::Process do
  context "mp3" do
    track = PL2USB::Track.new(Plist::parse_xml(PLAYLIST_XML)["Tracks"]["2261"])
    process = PL2USB::Process.new(track)

    it "should copy" do
      expect(process.copy).to be true
      expect(::File.exist?(track.destination.path)).to be true
      expect(::File.symlink?(track.destination.path)).to be false
      ::FileUtils::rm_f(track.destination.path)
    end

    it "should symlink" do
      expect(process.symlink).to be true
      expect(::File.symlink?(track.destination.path)).to be true
      ::FileUtils::rm_f(track.destination.path)
    end
  end

  context "with an alac file" do
    track = PL2USB::Track.new(Plist::parse_xml(PLAYLIST_XML)["Tracks"]["14605"])
    convert = PL2USB::Process.new(track)

    it "should be compress" do
      expect(convert.process).to be true
      expect(::File.exist?(track.destination.path)).to be true
      ::FileUtils::rm_f(track.destination.path)
    end
  end
end
