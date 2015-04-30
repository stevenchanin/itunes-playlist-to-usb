RSpec.describe PlaylistManager do
  SETTINGS["playlist"] = File.join(TEST_DIR, "playlist.xml")
  playlist = PlaylistManager.new

  context "with an playlist file" do
    it "should have correct number of tracks" do
      expect(playlist.tracks.count).to eql 15
    end

    it "tracks should be an id and a track" do
      expect(playlist.tracks.first.first).to be_a_kind_of(String)
      expect(playlist.tracks.first.last).to be_a_kind_of(Track)
    end
  end
end
