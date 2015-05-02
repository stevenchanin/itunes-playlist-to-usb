module PL2USB
  require 'audioinfo'
  class File
    attr_reader :length
    attr_reader :extension
    attr_reader :size
    attr_reader :path
    attr_reader :kind
    attr_reader :bitrate

    def initialize path, kind
      @path = path
      @kind = kind
      @codec_info = YAML.load_file(::File.join(::File.dirname(__FILE__), "../../etc/codecs.yml"))[@kind]
      @extension = @codec_info["extension"]

      begin
        @info = ::AudioInfo.new(path)
        @length = @info.length
        @size = ::File.size(path)
        @bitrate = @info.bitrate
      rescue
        @info = nil
        @length = nil
        @size = nil
        @bitrate = nil
      end
    end

    def lossless?
      @codec_info["lossless"]
    end

    def exist?
      ::File.exist? path
    end
  end
end
