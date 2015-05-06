RSpec.describe PL2USB::Process do
  context "mp3" do
    track = PL2USB::Track.new(Plist::parse_xml(PLAYLIST_XML)["Tracks"]["2261"])
    process = PL2USB::Process.new(track)

    it "should find a compressor" do
      expect(process.compressor).to be_a_kind_of String
    end

    it "should have the libmp3lame encoder" do
      expect { system("#{process.compressor} -encoders") }.to output(/libmp3lame MP3 \(MPEG audio layer 3\)/).to_stdout_from_any_process
    end

    it "should have the alac decoder" do
      expect { system("#{process.compressor} -decoders") }.to output(/AAC \(Advanced Audio Coding\)/).to_stdout_from_any_process
    end

    it "should symlink as the import method" do
      expect(process.import_method).to eql "symlink"
    end

    it "should copy" do
      expect(process.copy).to be true
      expect(::File.exist?(track.destination.path)).to be true
      expect(::File.symlink?(track.destination.path)).to be false
      ::FileUtils::rm_f(track.destination.path)
    end

    it "should symlink" do
      expect(process.symlink).to be true
      expect(::File.symlink?(track.destination.path)).to be true
      ::FileUtils::rm_f(track.destination.path)
    end
  end

  context "with an alac file" do
    track = PL2USB::Track.new(Plist::parse_xml(PLAYLIST_XML)["Tracks"]["14605"])
    process = PL2USB::Process.new(track)

    it "should compress as the import method" do
      expect(process.import_method).to eql "compress"
    end

    it "should compress" do
      expect(process.process).to be true
      expect(::File.exist?(track.destination.path)).to be true
      ::FileUtils::rm_f(track.destination.path)
    end
  end
end
