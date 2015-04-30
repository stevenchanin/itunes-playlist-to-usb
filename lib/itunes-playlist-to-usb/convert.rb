class Convert
  require 'audioinfo'
  attr_reader :input_file

  def initialize track
    @track = track
    @codecs = YAML.load_file(File.join(File.dirname(__FILE__), "../../etc/codecs.yml"))
  end

  def run
    return false unless convert?
    cmd = "ffmpeg -i #{Shellwords.escape(input_file)} -codec:v copy -codec:a #{output_codec} -q:a 2 -threads #{SETTINGS["output"]["threads"]} #{Shellwords.escape(output_file)}"
    puts cmd
    system(cmd)
    File.unlink(input_file)
  end

  def output_codec
    @codecs[SETTINGS["output"]["codec"]]["codec"]
  end

  def convert?
    return false unless @track.lossless?
    return false if @track.exist?
    true
  end
end
