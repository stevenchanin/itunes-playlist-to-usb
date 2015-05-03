module PL2USB
  class LibraryPath
    # Take a track object and return what would be entered into the library. If
    # it's of a kind that the library doesn't support, then it will return the
    # information of what should be created.

    def initialize track, settings={:library_path => nil}
      @track = track
      @library_path = settings[:library_path] || SETTINGS["library_path"]
    end

    def path
      replacements = {
        "%A" => @track.album,
        "%T" => @track.snake_name,
        "%a" => @track.artist,
        "%e" => extension,
        "%g" => @track.genre,
        "%n" => @track.track_number,
        "%t" => @track.name,
        "%y" => @track.year,
      }

      p = @library_path
      replacements.each do |key,replacement|
        p = p.gsub(/#{key}/, replacement.to_s)
      end
      p
    end

    def file
      ::PL2USB::File.new(path, kind)
    end

    def convert?
      !SETTINGS["supported_codecs"].include?(@track.kind)
    end

    private
    def extension
      f = ::File.join(::File.dirname(__FILE__), "../../etc/codecs.yml")
      YAML.load_file(f)[kind]["extension"]
    end

    def kind
      if convert?
        SETTINGS["supported_codecs"].first
      else
        @track.kind
      end
    end
  end
end

