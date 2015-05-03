RSpec.describe PL2USB::LibraryPath do
  track = PL2USB::Track.new(Plist::parse_xml(PLAYLIST_XML)["Tracks"]["2261"])

  context "with format of '%a'" do
    SETTINGS["library_directory_format"] = '%a'
    library_path = PL2USB::LibraryPath.new(track)

    it "should have dirname of" do
      expect(library_path.dirname).to eql "Test1 Artist"
    end
  end

  context "with format of '%A'" do
    SETTINGS["library_directory_format"] = '%A'
    library_path = PL2USB::LibraryPath.new(track)

    it "should have dirname of" do
      expect(library_path.dirname).to eql "Test1 Album"
    end
  end

  context "with format of '%n'" do
    SETTINGS["library_directory_format"] = '%n'
    library_path = PL2USB::LibraryPath.new(track)

    it "should have dirname of" do
      expect(library_path.dirname).to eql "01"
    end
  end

  context "with format of '%t'" do
    SETTINGS["library_directory_format"] = '%t'
    library_path = PL2USB::LibraryPath.new(track)

    it "should have dirname of" do
      expect(library_path.dirname).to eql "Test1 Title"
    end
  end

  context "with format of '%y'" do
    SETTINGS["library_directory_format"] = '%y'
    library_path = PL2USB::LibraryPath.new(track)

    it "should have dirname of" do
      expect(library_path.dirname).to eql "2015"
    end
  end

end
