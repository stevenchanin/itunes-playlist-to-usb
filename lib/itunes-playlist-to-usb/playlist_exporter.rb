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

    get_exported_file
    get_target_directory

    Playlist.new.tracks.each do |id, track|
      add_track_to_catalog track
    end

    initialize_catalog
    process_tracks

    copy_catalog
  end

  private
  def get_exported_file
    SETTINGS["playlist"]
  end

  def get_target_directory
    SETTINGS["output"]["directory"]
  end

  def initialize_catalog
    @catalog = {}
  end

  def add_track_to_catalog(info)
    # TODO: migrate this logic into the track class.
    name = clean_string(info.name)
    album = clean_string(info.album, 25)
    genre = clean_string(info.genre, 20)
    track_number = info.track_number || 0

    begin
      file_uri = URI(info["Location"])

      original_file = URI.decode(file_uri.path)
      original_file =~ /.*\.(.*)/
      file_type = $1

      @catalog[genre] ||= {}
      @catalog[genre][album] ||= []

      target_name = ("%02d-"  % track_number) + "#{name}.#{file_type}"
      @catalog[genre][album] << {:name => target_name, :file => original_file}
    rescue
      puts "** Error trying to process:\n\t#{name}: #{info}"
    end
  end

  def clean_string(s, cutoff_at = nil)
    unless s.is_a?(String)
      s = 'Blank'
    end

    if cutoff_at
      s = s[0, cutoff_at]
    end

    s && s.gsub(/\/|\(|\)/, '_')
  end

  def copy_catalog
    say "Beginning Copy", :green
    @catalog.each do |genre, albums|
      puts "Genre: #{genre}"
      genre_path = "#{@target_directory}/#{genre}"

      unless options.debug?
        FileUtils.mkdir(genre_path) unless File.exists?(genre_path)
      end

      albums.each do |album, tracks|
        puts "  Album: #{album}"
        album_path = "#{@target_directory}/#{genre}/#{album}"

        unless options.debug?
          FileUtils.mkdir(album_path) unless File.exists?(album_path)
        end

        tracks.each do |track|
          full_destination = "#{@target_directory}/#{genre}/#{album}/#{track[:name]}"
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
