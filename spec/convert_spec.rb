RSpec.describe PL2USB::Convert do
  context "mp3" do
    track = PL2USB::Track.new(Plist::parse_xml(PLAYLIST_XML)["Tracks"]["2261"])
    convert = PL2USB::Convert.new(track)

    it "should not be convertable" do
      expect(convert.convertable?).to be false
    end

    it "it should not convert" do
      expect(convert.run).to be false
    end
  end

  context "with an alac file" do
    track = PL2USB::Track.new(Plist::parse_xml(PLAYLIST_XML)["Tracks"]["14605"])
    convert = PL2USB::Convert.new(track)

    it "it should be converted" do
      expect(convert.convertable?).to be true
    end

    it "it should be convert" do
      expect(convert.run).to be true
      expect(::File.exist?(track.destination.path)).to be true
      ::FileUtils::rm_f(track.destination.path)
    end
  end
end
