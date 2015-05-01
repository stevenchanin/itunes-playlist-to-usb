#RSpec.describe Convert do
#  SETTINGS["playlist"] = File.join(TEST_DIR, "playlist.xml")
#  context "with an mp3 file" do
#    track = Track.new({
#      "Track ID"=>2261,
#      "Name"=>"Skin & Bones Blues",
#      "Artist"=>"Honeyboy Edwards",
#      "Album"=>"Crawling Kingsnake",
#      "Genre"=>"Blues",
#      "Kind"=>"MPEG audio file",
#      "Size"=>6608553,
#      "Total Time"=>153887,
#      "Track Number"=>7,
#      "Year"=>1964,
#      "Date Modified"=>"",
#      "Date Added"=>"",
#      "Bit Rate"=>320,
#      "Sample Rate"=>44100,
#      "Play Count"=>3,
#      "Play Date"=>3490444729,
#      "Play Date UTC"=>"",
#      "Skip Count"=>1,
#      "Skip Date"=>"",
#      "Artwork Count"=>1,
#      "Persistent ID"=>"31E962ED2DB7032B",
#      "Track Type"=>"File",
#      "Location"=>"file:///Volumes/HDD/iTunes/iTunes%20Media/Music/Honeyboy%20Edwards/Crawling%20Kingsnake/07%20Skin%20&%20Bones%20Blues.mp3",
#      "File Folder Count"=>5,
#      "Library Folder Count"=>1,
#    })
#
#    mp3 = Convert.new(track)
#
#    it "should use mp3 as the output codec" do
#      expect(mp3.output_codec).to eql "libmp3lame"
#    end
#
#    it "should not be converted" do
#      expect(mp3.convert?).to be false
#    end
#  end
#
#  context "with an alac file" do
#    track = Track.new({
#      "Track ID"=>19941,
#      "Name"=>"Come As You Are",
#      "Artist"=>"Nirvana",
#      "Album"=>"Nevermind",
#      "Genre"=>"Grunge",
#      "Kind"=>"Apple Lossless audio file",
#      "Size"=>26334897,
#      "Total Time"=>219106,
#      "Track Number"=>3,
#      "Track Count"=>12,
#      "Year"=>1991,
#      "Date Modified"=>"",
#      "Date Added"=>"",
#      "Bit Rate"=>917,
#      "Sample Rate"=>44100,
#      "Artwork Count"=>1,
#      "Persistent ID"=>"4AF9F5E4A581DD31",
#      "Track Type"=>"File",
#      "Location"=>"file:///Volumes/HDD/iTunes/iTunes%20Media/Music/Nirvana/Nevermind/03%20Come%20As%20You%20Are.m4a",
#      "File Folder Count"=>5,
#      "Library Folder Count"=>1
#    })
#
#    alac = Convert.new(track)
#
#    it "should use mp3 as the output codec" do
#      expect(alac.output_codec).to eql "libmp3lame"
#    end
#
#    it "it should be converted" do
#      expect(alac.convert?).to be true
#    end
#  end
#end
