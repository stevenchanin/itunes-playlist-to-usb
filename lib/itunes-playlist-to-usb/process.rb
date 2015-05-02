module PL2USB
  class Process
    require 'fileutils'
    require 'shellwords'

    attr_reader :codec

    def initialize track
      @track = track
      @codec = track.destination.codec
    end

    def process
      unless @track.source.exist?
        return "skipping #{id} because it's source file is gone!"
      end

      if @track.destination.exist?
        return "skipping #{id} because it already exists"
      end

      make_destination_directory
      @track.source.lossless? ? compress : copy
    end

    def source
      Shellwords.escape(@track.source.path)
    end

    def destination
      Shellwords.escape(@track.destination.path)
    end

    private
    def compress
      cmd = "ffmpeg -i #{source} -codec:v copy -codec:a #{codec} -q:a 2 #{destination} &> /dev/null"
      system(cmd)
    end

    def copy
      ::FileUtils.cp(@track.source.path, @track.destination.path)
      true
    end

    def make_destination_directory
      ::FileUtils.mkdir_p(::File.dirname(@track.destination.path))
    end
  end
end




