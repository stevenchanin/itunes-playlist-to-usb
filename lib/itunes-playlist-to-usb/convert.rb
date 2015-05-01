class Convert
  require 'fileutils'
  require 'shellwords'

  def initialize track
    @track = track
    @codecs = YAML.load_file(File.join(File.dirname(__FILE__), "../../etc/codecs.yml"))
  end

  def run
    input_file = Shellwords.escape(@track.location)
    output_file = Shellwords.escape(@track.output_location)
    output_codec = @codecs[SETTINGS["output"]["codec"]]["codec"]
    cmd = "ffmpeg -i #{input_file} -codec:v copy -codec:a #{output_codec} -q:a 2 #{output_file} &> /dev/null"
    #puts cmd
    FileUtils.mkdir_p(File.dirname(@track.output_location))
    system(cmd)
  end
end
