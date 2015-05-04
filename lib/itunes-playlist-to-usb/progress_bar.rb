module PL2USB
  class ProgressBar
    require 'ruby-progressbar'

    attr_accessor :debug
    attr_reader   :verbose

    def initialize options={:verbose=>true, :debug=>false}
      @debug = options[:debug]
      @verbose = options[:verbose]
      if verbose
        @progress_bar ||= ::ProgressBar.create
        @progress_bar.format = "%c of %C |%B| %P\%"
      end
    end

    def verbose= v
      @verbose = v
      if @verbose
        @progress_bar ||= ::ProgressBar.create
        @progress_bar.format = "%c of %C |%B| %P\%"
      end
    end

    def increment
      @progress_bar.increment if verbose
    end

    def total
      @progress_bar.total if verbose
    end

    def total= v
      @progress_bar.total=v if verbose
    end

    def log string
      if verbose
        @progress_bar.log(string)
        true
      else
        false
      end
    end

    def debug_log string
      if verbose && debug
        @progress_bar.log(string)
        true
      else
        false
      end
    end
  end
end
