module PL2USB
  class Playlist
    require 'plist'

    attr_reader :tracks

    def initialize xml
      PROGRESS_BAR.debug_log("Parsing the playlist file")
      @tracks = Plist::parse_xml(xml)["Tracks"]
      @tracks = @tracks.map{|id,data| Track.new(data) }
    end

    def tracks options={:type=>"any"}
      case options[:type]
      when "any"
        @tracks
      when "lossless"
        @tracks.map{|t| t if t.source.lossless?}.compact
      when "lossy"
        @tracks.map{|t| t unless t.source.lossless?}.compact
      end
    end
  end
end
