module PL2USB
  class LibraryPath
    def initialize track, settings={:library_path => nil}
      @track = track
      @library_path = settings[:library_path] || SETTINGS["library_path"]
    end

    def path
      replacements = {
        "%A" => @track.album,
        "%a" => @track.artist,
        "%n" => @track.track_number,
        "%T" => @track.snake_name,
        "%t" => @track.name,
        "%y" => @track.year,
      }

      dir = @library_path
      replacements.each do |key,replacement|
        dir.gsub!(/#{key}/, replacement.to_s)
      end
      dir
    end

    def basename
      #@track.name.downcase.gsub(/[^a-z0-9]/, '_')
      ::File.basename(path)
    end

    def dirname
      ::File.dirname(path)
    end
  end
end

