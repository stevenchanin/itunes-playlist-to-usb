require 'filemagic'
class Convert
  def initialize file
    @file = file
    @type = FileMagic.open(:mime) { |fm| fm.file(@file, true) }
  end
end
