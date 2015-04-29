class Convert
  require 'audioinfo'
  attr_reader :file_in
  attr_reader :file_out

  def initialize file
    @codecs = YAML.load_file(File.join(File.dirname(__FILE__), "../../etc/codecs.yml"))
    @meta = AudioInfo.open(file)

    @file_in = file
    @file_out = file.gsub(/[^\.]+$/, @codecs[encoding]["extension"])
  end

  def run
    return true unless lossless
    return true if File.exist?(file_out)
    system("ffmpeg -i '#{file_in}' -codec:v copy -codec:a #{output_codec} -q:a 2 '#{file_out}'")
    File.unlink(file_in)
  end

  private
  def encoding
    if @meta.info.extension == "mp3"
      "mp3"
    else
      @meta.info.instance_variable_get(:@info_atoms)["ENCODING"]
    end
  end

  def lossless
    @codecs[encoding]["lossless"]
  end

  def output_codec
    @codecs[SETTINGS["output"]["codec"]]
  end

end
