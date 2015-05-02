module PL2USB
  require 'audioinfo'
  class File
    attr_reader :length
    attr_reader :extension
    attr_reader :size
    attr_reader :path

    def initialize path
      @path = path
      @info = ::AudioInfo.new(path)
      @length = @info.length
      @extension = @info.extension.downcase
      @size = ::File.size(path)
    end

    def lossless?
      # FIXME: m4a's can be lossy or lossless.
      extension != "mp3"
    end

    def exist?
      ::File.exist? path
    end

  end
end
