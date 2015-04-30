RSpec.describe PlaylistManager do
  SETTINGS["playlist"] = File.join(TEST_DIR, "playlist.xml")
  playlist = PlaylistManager.new

  context "with an playlist file" do
    it "should have correct number of tracks" do
      expect(playlist.tracks.count).to eql 15
    end
  end
end
