RSpec.describe PL2USB::LibraryPath do
  original_directory_format = SETTINGS["library_directory_format"]
  track = PL2USB::Track.new(Plist::parse_xml(PLAYLIST_XML)["Tracks"]["2261"])

  context "with library_path of '%a'" do
    library_path = PL2USB::LibraryPath.new(track, :library_path=>'/tmp/%a/file.mp3')

    it "should have correct dirname" do
      expect(library_path.file.dirname).to eql "/tmp/Test1 Artist"
    end

    it "should have correct basename" do
      expect(library_path.file.basename).to eql "file.mp3"
    end
  end

  context "with library_path of '%A'" do
    library_path = PL2USB::LibraryPath.new(track, :library_path=>'/tmp/%A/file.mp3')

    it "should have dirname of" do
      expect(library_path.file.dirname).to eql "/tmp/Test1 Album"
    end
  end

  context "with library_path of '%n'" do
    library_path = PL2USB::LibraryPath.new(track, :library_path=>'/tmp/%n/file.mp3')

    it "should have dirname of" do
      expect(library_path.file.dirname).to eql "/tmp/01"
    end
  end

  context "with library_path of '%t'" do
    library_path = PL2USB::LibraryPath.new(track, :library_path=>'/tmp/%t/file.mp3')

    it "should have dirname of" do
      expect(library_path.file.dirname).to eql "/tmp/Test1 Title"
    end
  end

  context "with library_path of '%T'" do
    library_path = PL2USB::LibraryPath.new(track, :library_path=>'/tmp/%a/%T')

    it "should have correct basename" do
      expect(library_path.file.basename).to eql "test1_title"
    end
  end

  context "with library_path of '%y'" do
    library_path = PL2USB::LibraryPath.new(track, :library_path=>'/tmp/%y/file.mp3')

    it "should have dirname of" do
      expect(library_path.file.dirname).to eql "/tmp/2015"
    end
  end

  context "with library_path of '%g'" do
    library_path = PL2USB::LibraryPath.new(track, :library_path=>'/tmp/%g/file.mp3')

    it "should have dirname of" do
      expect(library_path.file.dirname).to eql "/tmp/Test1 Genre"
    end
  end
end
