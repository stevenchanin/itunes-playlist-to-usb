class PlaylistExporter < Thor
  desc "process", "process playlist"
  method_option :verbose, :type => :boolean, :default => false, :aliases => "-v",
:desc => "running in verbose mode will also show each file as it's copied"
  method_option :debug, :type => :boolean, :default => false, :aliases => "-d",
:desc => "in debug mode files will not actually be copied"
  method_option :force, :type => :boolean, :default => false, :aliases => "-f",
:desc => "normally, copying a file is skipped if a file with the same name and size already exists in the destination. Force mode always copies."

  def process
    puts "*** Verbose Mode" if options.verbose?
    puts "*** Debug Mode" if options.debug?
    puts "*** Force Mode" if options.force?


    @catalog = {}
    PlaylistManager.new.tracks.each do |id, track|
      puts "Processing #{track.artist} - #{track.album} - #{track.name}"
      track.save
    end
  end

end
