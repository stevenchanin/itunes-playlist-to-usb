RSpec.describe Track do
  context "mp3 track" do
    track = Track.new({
      "Track ID"=>2261,
      "Name"=>"Skin & Bones Blues",
      "Artist"=>"Honeyboy Edwards",
      "Album"=>"Crawling Kingsnake",
      "Genre"=>"Blues",
      "Kind"=>"MPEG audio file",
      "Size"=>6608553,
      "Total Time"=>153887,
      "Track Number"=>7,
      "Year"=>1964,
      "Date Modified"=>"",
      "Date Added"=>"",
      "Bit Rate"=>320,
      "Sample Rate"=>44100,
      "Play Count"=>3,
      "Play Date"=>3490444729,
      "Play Date UTC"=>"",
      "Skip Count"=>1,
      "Skip Date"=>"",
      "Artwork Count"=>1,
      "Persistent ID"=>"31E962ED2DB7032B",
      "Track Type"=>"File",
      "Location"=>"file:///Volumes/HDD/iTunes/iTunes%20Media/Music/Honeyboy%20Edwards/Crawling%20Kingsnake/07%20Skin%20&%20Bones%20Blues.mp3",
      "File Folder Count"=>5,
      "Library Folder Count"=>1,
    })

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

    it "should have correct output_location" do
      expect(track.output_location).to eql "/tmp/Blues/Crawling Kingsnake/07 Skin & Bones Blues.mp3"
    end

    it "should not be lossless" do
      expect(track.lossless?).to be false
    end

    it "should not exist" do
      expect(track.exist?).to be false
    end

  end

  context "alac track" do
    track = Track.new({
      "Track ID"=>19941,
      "Name"=>"Come As You Are",
      "Artist"=>"Nirvana",
      "Album"=>"Nevermind",
      "Genre"=>"Grunge",
      "Kind"=>"Apple Lossless audio file",
      "Size"=>26334897,
      "Total Time"=>219106,
      "Track Number"=>3,
      "Track Count"=>12,
      "Year"=>1991,
      "Date Modified"=>"",
      "Date Added"=>"",
      "Bit Rate"=>917,
      "Sample Rate"=>44100,
      "Artwork Count"=>1,
      "Persistent ID"=>"4AF9F5E4A581DD31",
      "Track Type"=>"File",
      "Location"=>"file:///Volumes/HDD/iTunes/iTunes%20Media/Music/Nirvana/Nevermind/03%20Come%20As%20You%20Are.m4a",
      "File Folder Count"=>5,
      "Library Folder Count"=>1
    })


    it "should have correct id" do
      expect(track.id).to eql 19941
    end

    it "should have correct name" do
      expect(track.name).to eql "Come As You Are"
    end

    it "should have correct artist" do
      expect(track.artist).to eql "Nirvana"
    end

    it "should have correct album" do
      expect(track.album).to eql "Nevermind"
    end

    it "should have correct genre" do
      expect(track.genre).to eql "Grunge"
    end

    it "should have correct kind" do
      expect(track.kind).to eql "Apple Lossless audio file"
    end

    it "should have correct size" do
      expect(track.size).to eql 26334897
    end

    it "should have correct total_time" do
      expect(track.total_time).to eql 219106
    end

    it "should have correct track_number" do
      expect(track.track_number).to eql 3
    end

    it "should have correct year" do
      expect(track.year).to eql 1991
    end

    it "should have correct bit_rate" do
      expect(track.bit_rate).to eql 917
    end

    it "should have correct sample_rate" do
      expect(track.sample_rate).to eql 44100
    end

    it "should have correct play_count" do
      expect(track.play_count).to eql nil
    end

    it "should have correct skip_count" do
      expect(track.skip_count).to eql nil
    end

    it "should have correct artwork_count" do
      expect(track.artwork_count).to eql 1
    end

    it "should have correct persistent_id" do
      expect(track.persistent_id).to eql "4AF9F5E4A581DD31"
    end

    it "should have correct track_type" do
      expect(track.track_type).to eql "File"
    end

    it "should have correct location" do
      expect(track.location).to eql "/Volumes/HDD/iTunes/iTunes Media/Music/Nirvana/Nevermind/03 Come As You Are.m4a"
    end

    it "should have correct file_folder_count" do
      expect(track.file_folder_count).to eql 5
    end

    it "should have correct library_folder_count" do
      expect(track.library_folder_count).to eql 1
    end

    it "should have correct output_location" do
      expect(track.output_location).to eql "/tmp/Grunge/Nevermind/03 Come As You Are.mp3"
    end

    it "should not be lossless" do
      expect(track.lossless?).to be true
    end

    it "should not exist" do
      expect(track.exist?).to be false
    end

  end

end

