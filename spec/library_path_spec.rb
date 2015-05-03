RSpec.describe PL2USB::LibraryPath do

  context "with mp3 using default library_path" do
    track = PL2USB::Track.new(Plist::parse_xml(PLAYLIST_XML)["Tracks"]["2261"])
    library_path = PL2USB::LibraryPath.new(track)
    it "should have correct basename" do
      expect(library_path.file.path).to eql "/tmp/Test1 Artist/[2015] Test1 Album/01-test1_title.mp3"
    end
  end

  context "with mp3 using library_path of '/tmp/%g/%a/[%y] %A/%t/%n-%T.%e'" do
    track = PL2USB::Track.new(Plist::parse_xml(PLAYLIST_XML)["Tracks"]["2261"])
    library_path = PL2USB::LibraryPath.new(track, :library_path=>'/tmp/%g/%a/[%y] %A/%t/%n-%T.%e')

    it "should have correct dirname" do
      expect(library_path.file.dirname).to eql "/tmp/Test1 Genre/Test1 Artist/[2015] Test1 Album/Test1 Title"
    end

    it "should have correct basename" do
      expect(library_path.file.basename).to eql "01-test1_title.mp3"
    end
  end

  context "with alac using default library_path" do
    alac_track = PL2USB::Track.new(Plist::parse_xml(PLAYLIST_XML)["Tracks"]["14605"])
    library_path = PL2USB::LibraryPath.new(alac_track)

    it "should have correct basename" do
      expect(library_path.file.path).to eql "/tmp/Test2 Artist/[2009] Test2 Album/02-test2_title.mp3"
    end
  end

  context "with alac using library_path of '/tmp/%g/%a/[%y] %A/%t/%n-%T.%e'" do
    track = PL2USB::Track.new(Plist::parse_xml(PLAYLIST_XML)["Tracks"]["14605"])
    library_path = PL2USB::LibraryPath.new(track, :library_path=>'/tmp/%g/%a/[%y] %A/%t/%n-%T.%e')

    it "should convert" do
      expect(library_path.convert?).to be true
    end

    it "should have a file extension of m4a" do
      expect(library_path.file.extension).to eql "mp3"
    end

    it "should have correct basename" do
      expect(library_path.file.path).to eql "/tmp/Test2 Genre/Test2 Artist/[2009] Test2 Album/Test2 Title/02-test2_title.mp3"
    end
  end

  context "with an aac and" do
    track = PL2USB::Track.new(Plist::parse_xml(PLAYLIST_XML)["Tracks"]["6087"])

    context "default library_path" do
      library_path = PL2USB::LibraryPath.new(track)
      it "should have correct basename" do
        expect(library_path.file.path).to eql "/tmp/Test3 Artist/[1929] Test3 Album/01-test3_title.m4a"
      end
    end

    context "library_path of '/tmp/%g/%a/[%y] %A/%t/%n-%T.%e'" do
      library_path = PL2USB::LibraryPath.new(track, :library_path=>'/tmp/%g/%a/[%y] %A/%t/%n-%T.%e')

      it "should have correct basename" do
        expect(library_path.file.path).to eql "/tmp/Test3 Genre/Test3 Artist/[1929] Test3 Album/Test3 Title/01-test3_title.m4a"
      end
    end
  end

end
