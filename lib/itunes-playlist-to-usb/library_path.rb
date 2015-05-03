module PL2USB
  class LibraryPath
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
        "%n" => @track.track_number,
        "%t" => @track.name,
        "%y" => @track.year,
      }

      p = @library_path
      replacements.each do |key,replacement|
        p.gsub!(/#{key}/, replacement.to_s)
      end
      p
    end

    def file
      ::PL2USB::File.new(path, SETTINGS["supported_codecs"].first)
    end

    private
    def extension
      f = ::File.join(::File.dirname(__FILE__), "../../etc/codecs.yml")
      YAML.load_file(f)[@track.kind]["extension"]
    end
  end
end

