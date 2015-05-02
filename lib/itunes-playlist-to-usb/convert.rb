module PL2USB
  class Convert
    require 'fileutils'
    require 'shellwords'

    attr_reader :codec

    def initialize track
      @track = track
      @codec = track.destination.codec
    end

    def run
      return false unless convertable?
      cmd = "ffmpeg -i #{source} -codec:v copy -codec:a #{codec} -q:a 2 #{destination} &> /dev/null"
      ::FileUtils.mkdir_p(::File.dirname(destination))
      system(cmd)
      true
    end

    def source
      Shellwords.escape(@track.source.path)
    end

    def destination
      Shellwords.escape(@track.destination.path)
    end

    def convertable?
      @track.source.lossless?
    end
  end
end
