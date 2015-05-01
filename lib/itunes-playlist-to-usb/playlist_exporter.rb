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
      #add_track_to_catalog track
      track.save
    end

    #process_tracks
    #copy_catalog
  end

  private

  def add_track_to_catalog(info)
    begin
      @catalog[info.genre] ||= {}
      @catalog[info.genre][info.album] ||= []
      @catalog[info.genre][info.album] << {:output => info.output_location, :input => info.location}
    rescue
      puts "** Error trying to process:\n\t#{info.name}: #{info.location}"
    end
  end

  def copy_catalog
    say "Beginning Copy", :green
    @catalog.each do |genre, albums|
      puts "Genre: #{genre}"
      genre_path = "#{SETTINGS["output"]["directory"]}/#{genre}"

      unless options.debug?
        FileUtils.mkdir(genre_path) unless File.exists?(genre_path)
      end

      albums.each do |album, tracks|
        puts "  Album: #{album}"
        album_path = "#{SETTINGS["output"]["directory"]}/#{genre}/#{album}"

        unless options.debug?
          FileUtils.mkdir(album_path) unless File.exists?(album_path)
        end

        tracks.each do |track|
          full_destination = "#{SETTINGS["output"]["directory"]}/#{genre}/#{album}/#{track[:name]}"
          source = track[:file]

          if options.verbose?
            puts "    Creating   : #{track[:name]}"
            puts "       source  : #{track[:file]}"
          end

          if File.exists?(source)
            if options.force?
              copy_file(source, full_destination)
            else
              if File.exists?(full_destination) && (File.size(source) == File.size(full_destination))
                puts "       *** Destination file already exists: #{track[:name]}"
              else
                copy_file(source, full_destination)
              end
            end
          else
            puts "       *** Source does not exist"
          end
        end
      end
    end
  end

  def copy_file(source, full_destination)
    unless options.debug?
      FileUtils.copy_file(source, full_destination)
      Convert.new(full_destination).run
    end
  end
end
