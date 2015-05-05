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

    def orphaned_directories
      ::Dir.glob("#{library}**/*").delete_if do |p|
        ::File.file?(p) || ::Dir.entries(p).count != 2
      end
    end

    def expected
      @playlist.tracks.map{|t| t.destination.path }
    end

    def existing
      ::Dir.glob("#{library}**/*").map{|p| p if ::File::file?(p) }.compact
    end

    def delete_orphaned!
      delete_orphaned_files!
      delete_orphaned_directories!
    end

    def delete_orphaned_files!
      orphaned.each do |orphan|
        PROGRESS_BAR.debug_log("deleting orphaned file '#{orphan}'.")
        ::File.unlink(orphan)
      end
    end

    def delete_orphaned_directories!
      orphaned_directories.each do |directory|
        PROGRESS_BAR.debug_log("deleting empty directory '#{directory}'.")
        ::Dir.delete(directory)
      end
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
