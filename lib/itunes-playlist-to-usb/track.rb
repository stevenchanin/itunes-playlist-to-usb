class Track
  require 'uri'

  attr_reader :id
  attr_reader :name
  attr_reader :artist
  attr_reader :album
  attr_reader :genre
  attr_reader :kind
  attr_reader :size
  attr_reader :total_time
  attr_reader :track_number
  attr_reader :year
  attr_reader :date_modified
  attr_reader :date_added
  attr_reader :bit_rate
  attr_reader :sample_rate
  attr_reader :play_count
  attr_reader :skip_count
  attr_reader :skip_date
  attr_reader :artwork_count
  attr_reader :persistent_id
  attr_reader :track_type
  attr_reader :file_folder_count
  attr_reader :library_folder_count

  def initialize playlist_track
    if playlist_track.kind_of? Array
      @playlist_track = playlist_track.last
    else
      @playlist_track = playlist_track
    end

    @id = @playlist_track["Track ID"]
    @name = @playlist_track["Name"]
    @artist = @playlist_track["Artist"]
    @album = @playlist_track["Album"]
    @genre = @playlist_track["Genre"]
    @kind = @playlist_track["Kind"]
    @size = @playlist_track["Size"]
    @total_time = @playlist_track["Total Time"]
    @track_number = @playlist_track["Track Number"]
    @year = @playlist_track["Year"]
    @date_modified = @playlist_track["Date Modified"]
    @date_added = @playlist_track["Date Added"]
    @bit_rate = @playlist_track["Bit Rate"]
    @sample_rate = @playlist_track["Sample Rate"]
    @play_count = @playlist_track["Play Count"]
    @skip_count = @playlist_track["Skip Count"]
    @skip_date = @playlist_track["Skip Date"]
    @artwork_count = @playlist_track["Artwork Count"]
    @persistent_id = @playlist_track["Persistent ID"]
    @track_type = @playlist_track["Track Type"]
    @file_folder_count = @playlist_track["File Folder Count"]
    @library_folder_count = @playlist_track["Library Folder Count"]
  end

  def location
    URI.decode(@playlist_track["Location"]).gsub(/^file:\/\//, '')
  end
end
