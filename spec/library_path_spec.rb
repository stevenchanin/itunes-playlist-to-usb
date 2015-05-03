RSpec.describe PL2USB::LibraryPath do
  track = PL2USB::Track.new(Plist::parse_xml(PLAYLIST_XML)["Tracks"]["2261"])

  context "directory_format '%y'" do
    SETTINGS["library_directory_format"] = '%y'
    library_path = PL2USB::LibraryPath.new(track)

    it "should have dirname of" do
      expect(library_path.dirname).to eql "2015"
    end
  end
end
