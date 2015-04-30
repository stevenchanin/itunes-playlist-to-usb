RSpec.describe Track do
  SETTINGS["playlist"] = File.join(TEST_DIR, "playlist.xml")
  playlist = PlaylistManager.new
  track = Track.new(playlist.tracks.first)

  context "the first track" do
    it "should have correct id" do
      expect(track.id).to eql 2261
    end

    it "should have correct name" do
      expect(track.name).to eql "Skin & Bones Blues"
    end

    it "should have correct artist" do
      expect(track.artist).to eql "Honeyboy Edwards"
    end

    it "should have correct album" do
      expect(track.album).to eql "Crawling Kingsnake"
    end

    it "should have correct genre" do
      expect(track.genre).to eql "Blues"
    end

    it "should have correct kind" do
      expect(track.kind).to eql "MPEG audio file"
    end

    it "should have correct size" do
      expect(track.size).to eql 6608553
    end

    it "should have correct total_time" do
      expect(track.total_time).to eql 153887
    end

    it "should have correct track_number" do
      expect(track.track_number).to eql 7
    end

    it "should have correct year" do
      expect(track.year).to eql 1964
    end

    it "should have correct bit_rate" do
      expect(track.bit_rate).to eql 320
    end

    it "should have correct sample_rate" do
      expect(track.sample_rate).to eql 44100
    end

    it "should have correct play_count" do
      expect(track.play_count).to eql 3
    end

    it "should have correct skip_count" do
      expect(track.skip_count).to eql 1
    end

    it "should have correct artwork_count" do
      expect(track.artwork_count).to eql 1
    end

    it "should have correct persistent_id" do
      expect(track.persistent_id).to eql "31E962ED2DB7032B"
    end

    it "should have correct track_type" do
      expect(track.track_type).to eql "File"
    end

    it "should have correct location" do
      expect(track.location).to eql "/Volumes/HDD/iTunes/iTunes Media/Music/Honeyboy Edwards/Crawling Kingsnake/07 Skin & Bones Blues.mp3"
    end

    it "should have correct file_folder_count" do
      expect(track.file_folder_count).to eql 5
    end

    it "should have correct library_folder_count" do
      expect(track.library_folder_count).to eql 1
    end

  end
end

