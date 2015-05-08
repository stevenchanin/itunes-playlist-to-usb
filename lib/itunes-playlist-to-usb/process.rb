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
      unless @track.valid?
        if @track.destination.exist?
          PROGRESS_BAR.debug_log("deleting destination because it's invalid")
          ::File.unlink(@track.destination.path)
        end

        send(import_method)
      end
    end

    def import_method
      return "compress" if @track.convert?
      return "symlink" if SETTINGS["symlink_for_copy"]
      return "copy"
    end

    def source
      Shellwords.escape(@track.source.path)
    end

    def destination
      Shellwords.escape(@track.destination.path)
    end

    def copy
      make_destination_directory
      PROGRESS_BAR.debug_log("copying '#{@track.source.path}' to '#{@track.destination.path}'.")
      ::FileUtils.cp(@track.source.path, @track.destination.path)
      ::File.exist?(@track.destination.path)
    end

    def symlink
      make_destination_directory
      PROGRESS_BAR.debug_log("symlinking '#{@track.source.path}' to '#{@track.destination.path}'.")
      ::FileUtils.ln_s(@track.source.path, @track.destination.path)
      ::File.symlink?(@track.destination.path)
    end

    def compressor
      ENV["PATH"]="/usr/local/bin:/usr/bin:/bin"
      path = `which avconv || which ffmpeg`.strip
      return nil if path.empty?
      path
    rescue
      raise "The command 'which' wasn't found."
    end

    def encoders
      `#{compressor} -codecs`.each_line.map do |l|
        l[8..-1].split.first.gsub(/libmp3lame/, "mp3") if !!l.match(/^\s+.E/)
      end.compact
    end

    def decoders
      `#{compressor} -codecs`.each_line.map do |l|
        l[8..-1].split.first if !!l.match(/^\s+D/)
      end.compact
    end

    private
    def compress
      PROGRESS_BAR.debug_log("compressing '#{@track.source.path}' to '#{@track.destination.path}'.")
      make_destination_directory
      cmd = "#{compressor} -v quiet -i #{source} -codec:v copy -codec:a #{codec} -q:a 2 #{destination}"
      system(cmd)
      $?.success?
    rescue Interrupt => e
      ::File.unlink(@track.destination.path)
      PROGRESS_BAR.log("Exiting...")
      PROGRESS_BAR.clear
      exit 1
    end

    def make_destination_directory
      dir = ::File.dirname(@track.destination.path)
      unless ::File.directory? dir
        PROGRESS_BAR.debug_log("creating directory #{dir}")
        ::FileUtils.mkdir_p(dir)
      end
    end
  end
end
