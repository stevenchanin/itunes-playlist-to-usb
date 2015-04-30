class PlaylistManager
  require 'plist'

  attr_reader :file
  attr_reader :tracks

  def initialize
    @file = SETTINGS["playlist"]
    puts "Reading #{@file}"
    @export = Plist::parse_xml(file)
    @tracks = @export["Tracks"]
  end
end
