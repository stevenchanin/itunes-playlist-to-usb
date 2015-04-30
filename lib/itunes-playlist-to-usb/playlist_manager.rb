class PlaylistManager
  require 'plist'

  attr_reader :file
  attr_reader :tracks

  def initialize
    @file = SETTINGS["playlist"]
    @tracks = Plist::parse_xml(@file)["Tracks"]
    @tracks = @tracks.map{|id,data| [id, Track.new(data)] }
  end
end
