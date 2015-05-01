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

  def tracks options={:type=>"any"}
    case options[:type]
    when "any"
      @tracks
    when "lossless"
      @tracks.map{|t| t if t.last.lossless?}.compact
    when "lossy"
      @tracks.map{|t| t unless t.last.lossless?}.compact
    end
  end
end
