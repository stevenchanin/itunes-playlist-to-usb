module PL2USB
  class FileManager
    def initialize playlist
      @playlist = playlist
    end

    def missing
      expected - existing
    end

    def orphaned
      existing - expected
    end

    def expected
      @playlist.tracks.map{|t| t.destination.path }
    end

    def existing
      ::Dir.glob("#{library}**/*").map{|p| p if ::File::file?(p) }.compact
    end

    def library
      # TODO: refactor
      library_path = SETTINGS["library_path"].split("")
      destination_path = @playlist.tracks.first.destination.path.split("")

      dir = []
      position = 0
      library_path.each do |letter|
        if destination_path[position] == letter
          dir.push(letter)
          position += 1
        else
          break
        end
      end

      dir.join
    end
  end
end
