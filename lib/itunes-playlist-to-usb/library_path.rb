module PL2USB
  class LibraryPath
    def initialize track
      @track = track
      @format = SETTINGS["library_directory_format"]
    end

    def dirname
      replacements = {
        "%A" => @track.album,
        "%a" => @track.artist,
        "%n" => @track.track_number,
        "%t" => @track.name,
        "%y" => @track.year,
      }

      dir = @format
      replacements.each do |key,replacement|
        dir.gsub!(/#{key}/, replacement.to_s)
      end
      dir
    end

    def basename
      @track.name.downcase.gsub(/[^a-z0-9]/, '_')
    end

    def path
      ::File.join(dirname, basename)
    end
  end
end

