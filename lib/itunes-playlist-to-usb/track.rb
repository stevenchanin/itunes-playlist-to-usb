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
      @playlist_track = playlist_track
      @id = @playlist_track["Track ID"]
      @name = clean_string(@playlist_track["Name"])
      @artist = clean_string(@playlist_track["Album Artist"] || @playlist_track["Artist"])
      @album = clean_string(@playlist_track["Album"])
      @genre = clean_string(@playlist_track["Genre"])
      @kind = @playlist_track["Kind"]
      @length = @playlist_track["Total Time"] / 1000
      @year = @playlist_track["Year"]
      @artwork_count = @playlist_track["Artwork Count"]
    end

    def source
      PL2USB::File.new(
        URI.decode(@playlist_track["Location"]).gsub(/^file:\/\//, ''),
        kind
      )
    end

    def convert?
      !SETTINGS["supported_codecs"].include?(kind)
    end

    def destination
      PL2USB::LibraryPath.new(self).file
    end

    def valid?
      unless source.exist?
        PROGRESS_BAR.debug_log("#{id} has missing source file")
        return false
      end

      unless destination.exist?
        PROGRESS_BAR.debug_log("#{id} has not been added to library")
        return false
      end

      if (length - destination.length) > 1
        PROGRESS_BAR.debug_log("#{id} is #{destination.length} seconds instead of #{length} seconds.")
        return false
      end
      true
    end

    def track_number
      "%02d" % (@playlist_track["Track Number"] || 0)
    end

    def save
      PL2USB::Process.new(self).process
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
