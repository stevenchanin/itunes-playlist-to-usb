module PL2USB
  class LibraryPath
    def initialize track
      @track = track
    end

    def dirname
      outside_directory = SETTINGS["library_path"]
      inside_directory = SETTINGS["library_directory_format"]
      { "%y" => @track.year }.each do |key,replacement|
        inside_directory.gsub!(/#{key}/, replacement.to_s)
      end
      inside_directory
    end

    def basename
      @track.name.downcase.gsub(/[^a-z0-9]/, '_')
    end

    def path
      ::File.join(dirname, basename)
    end
  end
end

