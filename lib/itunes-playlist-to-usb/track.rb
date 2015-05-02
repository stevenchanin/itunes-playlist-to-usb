module PL2USB
  class Track
    require 'fileutils'
    require 'uri'

    attr_reader :id
    attr_reader :name
    attr_reader :artist
    attr_reader :album
    attr_reader :genre
    attr_reader :kind
    attr_reader :size
    attr_reader :total_time
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
      @name = clean_string(@playlist_track["Name"])
      @artist = clean_string(@playlist_track["Artist"])
      @album = clean_string(@playlist_track["Album"])
      @genre = clean_string(@playlist_track["Genre"])
      @kind = @playlist_track["Kind"]
      @size = @playlist_track["Size"]
      @total_time = @playlist_track["Total Time"]
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

    def source
      PL2USB::File.new(
        URI.decode(@playlist_track["Location"]).gsub(/^file:\/\//, '')
      )
    end

    def destination
      codecs = YAML.load_file(File.join(File.dirname(__FILE__), "../../etc/codecs.yml"))
      extension = codecs[SETTINGS["output"]["encoding"]]["extension"]
      n = name.downcase.gsub(/[^a-z0-9]/, '_')
      PL2USB::File.new(
        File.join(SETTINGS["output"]["library_directory"], genre, album, "#{track_number} #{n}.#{extension}")
      )
    end

    def track_number
      "%02d" % (@playlist_track["Track Number"] || 0)
    end

    def lossless?
      [ "Apple Lossless audio file" ].include?(kind)
    end

    def save
      unless source.exist?
        return "skipping #{id} because it's source file is gone!"
      end

      if destination.exist?
        return "skipping #{id} because it already exists"
      end

      if lossless?
        Convert.new(self).run
      else
        # just copy over
        FileUtils.mkdir_p(File.dirname(destination.path))
        FileUtils.cp(location, output_location)
        return "copying #{id} because it's missing"
      end

      true
    end

    private
    def clean_string(s, cutoff_at = nil)
      unless s.is_a?(String)
        s = 'Blank'
      end
      s = s[0, cutoff_at] if cutoff_at
      s && s.gsub(/\/|\(|\)/, '_')
      s.split.map(&:capitalize).join(" ")
    end

  end
end
