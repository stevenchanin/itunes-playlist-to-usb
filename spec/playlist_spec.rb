RSpec.describe PL2USB::Playlist do
  playlist = PL2USB::Playlist.new(PLAYLIST_XML)

  context "with an playlist file" do
    it "should have correct number of tracks" do
      expect(playlist.tracks.count).to eql 2
    end

    it "tracks should be an array of Tracks" do
      expect(playlist.tracks).to be_a_kind_of(Array)
      expect(playlist.tracks.first).to be_a_kind_of(PL2USB::Track)
    end

    it "should find just lossy tracks" do
      expect(playlist.tracks(:type=>"lossy").size).to eql 1
      expect(playlist.tracks(:type=>"lossy").first.name).to eql "Test1 Title"
    end

    it "should find just lossless tracks" do
      expect(playlist.tracks(:type=>"lossless").size).to eql 1
      expect(playlist.tracks(:type=>"lossless").first.name).to eql "Test2 Title"
    end
  end
end
