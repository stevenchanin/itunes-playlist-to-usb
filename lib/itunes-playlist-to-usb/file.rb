module PL2USB
  require 'audioinfo'

  class File
    attr_reader :codec
    attr_reader :extension
    attr_reader :kind
    attr_reader :path

    def initialize path, kind
      @path = path
      @kind = kind
      codec_info = YAML.load_file(::File.join(::File.dirname(__FILE__), "../../etc/codecs.yml"))[@kind]
      @codec = @codec_info["codec"]
      @extension = @codec_info["extension"]
      @lossless = @codec_info["lossless"]
    end

    def lossless?
      @lossless
    end

    def exist?
      ::File.exist? path
    end

    def size
      exist? ? ::File.size(path) : nil
    end

    def length
      begin
        ::AudioInfo.new(path).length
      rescue
        nil
      end
    end

    def bitrate
      begin
        ::AudioInfo.new(path).bitrate
      rescue
        nil
      end
    end

    def basename
      ::File.basename(path)
    end

    def dirname
      ::File.dirname(path)
    end

  end
end
