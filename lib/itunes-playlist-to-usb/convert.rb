class Convert
  require 'filemagic'

  def initialize file
    @file_in = file
    @file_out = file.gsub(/[^\.]+$/, CODEC["extension"])
    @type = FileMagic.open(:mime) { |fm| fm.file(@file_in, true) }
  end

  def run
    return true if File.exist?(@file_out)
    return true if @type == CODEC["magic"]
    system("ffmpeg -i '#{@file_in}' -codec:v copy -codec:a #{CODEC["codec"]} -q:a 2 '#{@file_out}'")
  end
end
