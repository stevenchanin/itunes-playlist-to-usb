module PL2USB
  require 'audioinfo'
  class File
    attr_reader :extension
    attr_reader :path
    attr_reader :kind

    def initialize path, kind
      @path = path
      @kind = kind
      @codec_info = YAML.load_file(::File.join(::File.dirname(__FILE__), "../../etc/codecs.yml"))[@kind]
      @extension = @codec_info["extension"]
    end

    def lossless?
      @codec_info["lossless"]
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

  end
end
