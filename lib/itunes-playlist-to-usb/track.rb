module PL2USB
  class Track
    require 'fileutils'
    require 'uri'

    attr_reader :id
    attr_reader :name
    attr_reader :artist
    attr_reader :album
    attr_reader :genre
    attr_reader :length
    attr_reader :year
    attr_reader :artwork_count

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
      @length = @playlist_track["Total Time"]
      @year = @playlist_track["Year"]
      @artwork_count = @playlist_track["Artwork Count"]
    end

    def source
      PL2USB::File.new(
        URI.decode(@playlist_track["Location"]).gsub(/^file:\/\//, ''),
        kind
      )
    end

    def destination
      # FIXME: refactor
      codecs = YAML.load_file(::File.join(::File.dirname(__FILE__), "../../etc/codecs.yml"))
      extension = codecs[SETTINGS["output"]["encoding"]]["extension"]
      n = name.downcase.gsub(/[^a-z0-9]/, '_')
      PL2USB::File.new(
        ::File.join(SETTINGS["output"]["library_directory"], genre, album, "#{track_number} #{n}.#{extension}"),
        SETTINGS["output"]["encoding"]
      )
    end

    def track_number
      "%02d" % (@playlist_track["Track Number"] || 0)
    end

    def save
      unless source.exist?
        return "skipping #{id} because it's source file is gone!"
      end

      if destination.exist?
        return "skipping #{id} because it already exists"
      end

      if source.lossless?
        Convert.new(self).run
      else
        # just copy over
        FileUtils.mkdir_p(::File.dirname(destination.path))
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

    def kind
      case @kind
      when "MPEG audio file"
        "mp3"
      when "Apple Lossless audio file"
        "alac"
      when "AAC audio file"
        "aac"
      else
        nil
      end
    end

  end
end
