#RSpec.describe PL2USB::Track do
#  context "mp3 track" do
#    track = PL2USB::Track.new(Plist::parse_xml(PLAYLIST_XML)["Tracks"]["2261"])
#
#    it "should have correct id" do
#      expect(track.id).to eql 2261
#    end
#
#    it "should have correct name" do
#      expect(track.name).to eql "Test1 Title"
#    end
#
#    it "should have correct artist" do
#      expect(track.artist).to eql "Test1 Artist"
#    end
#
#    it "should have correct album" do
#      expect(track.album).to eql "Test1 Album"
#    end
#
#    it "should have correct genre" do
#      expect(track.genre).to eql "Test1 Genre"
#    end
#
#    it "should have correct kind" do
#      expect(track.kind).to eql "MPEG audio file"
#    end
#
#    it "should have correct size" do
#      expect(track.size).to eql 199850
#    end
#
#    it "should have correct total_time" do
#      expect(track.total_time).to eql 12
#    end
#
#    it "should have correct track_number" do
#      expect(track.track_number).to eql "01"
#    end
#
#    it "should have correct year" do
#      expect(track.year).to eql 2015
#    end
#
#    it "should have correct bit_rate" do
#      expect(track.bit_rate).to eql 128
#    end
#
#    it "should have correct sample_rate" do
#      expect(track.sample_rate).to eql 44100
#    end
#
#    it "should have correct artwork_count" do
#      expect(track.artwork_count).to eql 1
#    end
#
#    it "should have correct track_type" do
#      expect(track.track_type).to eql "File"
#    end
#
#    it "should have correct source_file" do
#      expect(track.source_file).to eql "#{File.dirname(__FILE__)}/test_files/test1.mp3"
#    end
#
#    it "should have correct output_location" do
#      expect(track.output_location).to eql "/tmp/Test1 Genre/Test1 Album/01 test1_title.mp3"
#    end
#
#    it "should not be lossless" do
#      expect(track.lossless?).to be false
#    end
#
#    it "should not exist" do
#      expect(track.exist?).to be false
#    end
#
#  end
#
#  context "alac track" do
#    track = PL2USB::Track.new(Plist::parse_xml(PLAYLIST_XML)["Tracks"]["14605"])
#
#    it "should have correct id" do
#      expect(track.id).to eql 14605
#    end
#
#    it "should have correct name" do
#      expect(track.name).to eql "Test2 Title"
#    end
#
#    it "should have correct artist" do
#      expect(track.artist).to eql "Test2 Artist"
#    end
#
#    it "should have correct album" do
#      expect(track.album).to eql "Test2 Album"
#    end
#
#    it "should have correct genre" do
#      expect(track.genre).to eql "Test2 Genre"
#    end
#
#    it "should have correct kind" do
#      expect(track.kind).to eql "Apple Lossless audio file"
#    end
#
#    it "should have correct size" do
#      expect(track.size).to eql 993049
#    end
#
#    it "should have correct total_time" do
#      expect(track.total_time).to eql 11
#    end
#
#    it "should have correct track_number" do
#      expect(track.track_number).to eql "02"
#    end
#
#    it "should have correct year" do
#      expect(track.year).to eql 2009
#    end
#
#    it "should have correct bit_rate" do
#      expect(track.bit_rate).to eql 702
#    end
#
#    it "should have correct sample_rate" do
#      expect(track.sample_rate).to eql 44100
#    end
#
#    it "should have correct artwork_count" do
#      expect(track.artwork_count).to eql 1
#    end
#
#    it "should have correct track_type" do
#      expect(track.track_type).to eql "File"
#    end
#
#    it "should have correct source file" do
#      expect(track.source_file).to eql "#{File.dirname(__FILE__)}/test_files/test2.m4a"
#    end
#
#    it "should have correct output_location" do
#      expect(track.output_location).to eql "/tmp/Test2 Genre/Test2 Album/02 test2_title.mp3"
#    end
#
#    it "should not be lossless" do
#      expect(track.lossless?).to be true
#    end
#
#    it "should not exist" do
#      expect(track.exist?).to be false
#    end
#
#  end
#
#end
