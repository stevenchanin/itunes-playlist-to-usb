class Convert
  require 'audioinfo'
  attr_reader :input_file

  def initialize file
    @codecs = YAML.load_file(File.join(File.dirname(__FILE__), "../../etc/codecs.yml"))
    @meta = AudioInfo.open(file)

    @input_file = file
  end

  def run
    return false unless convert?
    system("ffmpeg -i #{Shellwords.escape(file_in)} -codec:v copy -codec:a #{output_codec} -q:a 2 #{Shellwords.escape(file_out)}")
    File.unlink(file_in)
  end

  def encoding
    if @meta.extension == "mp3"
      "mp3"
    else
      @meta.info.instance_variable_get(:@info_atoms)["ENCODING"]
    end
  end

  def lossless
    @codecs[encoding]["lossless"]
  end

  def output_file
    extension = @codecs[SETTINGS["output"]["encoding"]]["extension"]
    file = File.basename(@meta.path)
    dir = SETTINGS["output"]["directory"]
    File.join(dir, file.gsub(/[^\.]+$/, extension))
  end

  def output_codec
    @codecs[SETTINGS["output"]["codec"]]["codec"]
  end

  def convert?
    return false unless lossless
    return false if File.exist?(output_file)
    true
  end
end
