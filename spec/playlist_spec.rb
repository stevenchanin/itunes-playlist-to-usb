RSpec.describe PlaylistManager do
  playlist = PlaylistManager.new(PLAYLIST)

  context "with an playlist file" do
    it "should have correct number of tracks" do
      expect(playlist.tracks.count).to eql 15
    end

    it "tracks should be an id and Track" do
      expect(playlist.tracks.first.first).to be_a_kind_of(String)
      expect(playlist.tracks.first.last).to be_a_kind_of(Track)
    end
  end
end
