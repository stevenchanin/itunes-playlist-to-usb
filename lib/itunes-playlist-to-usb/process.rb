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
        PROGRESS_BAR.debug_log("skipping #{@track.id} because it's source file is gone!")
        return false
      end

      if @track.destination.exist?
        PROGRESS_BAR.debug_log("skipping #{@track.id} because it already exists")
        return false
      end

      make_destination_directory
      @track.convert? ? compress : copy
    end

    def source
      Shellwords.escape(@track.source.path)
    end

    def destination
      Shellwords.escape(@track.destination.path)
    end

    private
    def compress
      PROGRESS_BAR.debug_log("compressing #{@track.id}")
      cmd = "ffmpeg -i #{source} -codec:v copy -codec:a #{codec} -q:a 2 #{destination} &> /dev/null"
      system(cmd)
      $?.success?
    end

    def copy
      PROGRESS_BAR.debug_log("copying #{@track.id}")
      ::FileUtils.cp(@track.source.path, @track.destination.path)
      ::File.exist?(@track.destination.path)
    end

    def make_destination_directory
      ::FileUtils.mkdir_p(::File.dirname(@track.destination.path))
    end
  end
end
