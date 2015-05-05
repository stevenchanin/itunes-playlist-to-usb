module PL2USB
  class LibraryPath
    # Take a track object and return what would be entered into the library. If
    # it's of a kind that the library doesn't support, then it will return the
    # information of what should be created.

    require 'unidecode'

    def initialize track, settings={:library_path => nil}
      @track = track
      @library_path = settings[:library_path] || SETTINGS["library_path"]
    end

    def path
      replacements = {
        "%A" => clean(@track.album),
        "%a" => clean(@track.artist),
        "%e" => CODECS[kind]["extension"],
        "%g" => clean(@track.genre),
        "%n" => @track.track_number,
        "%t" => clean(@track.name),
        "%y" => @track.year,
      }

      p = @library_path
      replacements.each do |key,replacement|
        p = p.gsub(/#{key}/, replacement.to_s)
      end
      p
    end

    def file
      ::PL2USB::File.new(path, kind)
    end

    private
    def kind
      if @track.convert?
        SETTINGS["supported_codecs"].first
      else
        @track.kind
      end
    end

    def clean input
      input.to_s.downcase!
      input.gsub!(/[\.,']/, '')             # strip punctuation
      input.gsub!(/&/, 'and')               # expand &
      input.gsub!(/ø/, 'o')                 # unicoder doesn't handle that well
      input.gsub!(/Æ/, 'ae')                # unicoder doesn't handle that well
      input = Unidecoder::decode(input)     # convert into ascii
      input.gsub!(/[^[:alnum:]\[\]]/, '_')  # replace non_alphanumeric
      input.gsub!(/_+/, '_')                # remove double underscores
      input.gsub!(/^_?/, '')                # must not start with underscores
      input.gsub!(/_?$/, '')                # must not end with underscores
    end
  end
end

