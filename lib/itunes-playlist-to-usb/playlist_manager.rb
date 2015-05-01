class PlaylistManager
  require 'plist'

  attr_reader :file
  attr_reader :tracks

  def initialize
    @file = SETTINGS["playlist"]
    puts "reading #{@file}"
    @tracks = Plist::parse_xml(@file)["Tracks"]
    puts "collecting track objects"
    @tracks = @tracks.map{|id,data| [id, Track.new(data)] }
  end
end
