RSpec.describe PL2USB::LibraryPath do

  context "with mp3 using default library_path" do
    track = PL2USB::Track.new(Plist::parse_xml(PLAYLIST_XML)["Tracks"]["2261"])
    library_path = PL2USB::LibraryPath.new(track)
    it "should have correct basename" do
      expect(library_path.file.path).to eql "/tmp/library/test1_artist/[2015] test1_album/01-test1_title.mp3"
    end
  end

  context "with mp3 using library_path of '/tmp/library/%g/%a/[%y] %A/%n-%t.%e'" do
    track = PL2USB::Track.new(Plist::parse_xml(PLAYLIST_XML)["Tracks"]["2261"])
    library_path = PL2USB::LibraryPath.new(track, :library_path=>'/tmp/library/%g/%a/[%y] %A/%n-%t.%e')

    it "should have correct dirname" do
      expect(library_path.file.dirname).to eql "/tmp/library/test1_genre/test1_artist/[2015] test1_album"
    end

    it "should have correct basename" do
      expect(library_path.file.basename).to eql "01-test1_title.mp3"
    end
  end

  context "with alac using default library_path" do
    alac_track = PL2USB::Track.new(Plist::parse_xml(PLAYLIST_XML)["Tracks"]["14605"])
    library_path = PL2USB::LibraryPath.new(alac_track)

    it "should have correct basename" do
      expect(library_path.file.path).to eql "/tmp/library/test2_artist/[2009] test2_album/02-test2_title.mp3"
    end
  end

  context "with alac using library_path of '/tmp/library/%g/%a/[%y] %A/%n-%t.%e'" do
    track = PL2USB::Track.new(Plist::parse_xml(PLAYLIST_XML)["Tracks"]["14605"])
    library_path = PL2USB::LibraryPath.new(track, :library_path=>'/tmp/library/%g/%a/[%y] %A/%n-%t.%e')

    it "should have a file extension of m4a" do
      expect(library_path.file.extension).to eql "mp3"
    end

    it "should have correct basename" do
      expect(library_path.file.path).to eql "/tmp/library/test2_genre/test2_artist/[2009] test2_album/02-test2_title.mp3"
    end
  end

  context "with an aac and" do
    track = PL2USB::Track.new(Plist::parse_xml(PLAYLIST_XML)["Tracks"]["6087"])

    context "default library_path" do
      library_path = PL2USB::LibraryPath.new(track)
      it "should have correct basename" do
        expect(library_path.file.path).to eql "/tmp/library/test3_artist/[1929] test3_album/01-test3_title.m4a"
      end
    end

    context "library_path of '/tmp/library/%g/%a/[%y] %A/%n-%t.%e'" do
      library_path = PL2USB::LibraryPath.new(track, :library_path=>'/tmp/library/%g/%a/[%y] %A/%n-%t.%e')

      it "should have correct basename" do
        expect(library_path.file.path).to eql "/tmp/library/test3_genre/test3_artist/[1929] test3_album/01-test3_title.m4a"
      end
    end
  end

end
