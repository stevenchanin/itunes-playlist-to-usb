RSpec.describe PL2USB::FileManager do
  context "with empty library" do
    file_manager = PL2USB::FileManager.new(PL2USB::Playlist.new(PLAYLIST_XML))

    it "should detect library directory" do
      expect(file_manager.library).to eql "/tmp/library/"
    end

    it "should not find any orphaned files" do
      ::FileUtils.rm_rf(file_manager.library)
      expect(file_manager.orphaned).to be_empty
    end

    it "should not find any existing files" do
      ::FileUtils.rm_rf(file_manager.library)
      expect(file_manager.existing).to be_empty
    end
  end

  context "with orphaned file" do
    file_manager = PL2USB::FileManager.new(PL2USB::Playlist.new(PLAYLIST_XML))
    it "should find orphaned file" do
      ::FileUtils.mkdir_p(file_manager.library)
      ::FileUtils.touch(::File.join(file_manager.library, "orphan.mp3"))
      expect(file_manager.orphaned).to eql ["/tmp/library/orphan.mp3"]
    end

    it "should not found any existing files" do
      ::FileUtils.rm_rf(file_manager.library)
      ::FileUtils.mkdir_p(::File.dirname(file_manager.expected.first))
      ::FileUtils.touch(file_manager.expected.first)
      expect(file_manager.existing.size).to eql 1
    end
  end
end
