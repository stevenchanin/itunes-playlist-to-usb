#!/usr/bin/env ruby

require 'thor'
require 'plist'
require 'uri'
require 'fileutils'

class PlaylistExporter < Thor
  desc "process", "process playlist"
  method_option :verbose, :type => :boolean, :default => false, :aliases => "-v",
:desc => "running in verbose mode will also show each file as it's copied"
  method_option :debug, :type => :boolean, :default => false, :aliases => "-d",
:desc => "in debug mode files will not actually be copied"
  def process
    puts "*** Verbose Mode" if options.verbose?
    puts "*** Debug Mode" if options.debug?

    get_exported_file
    get_target_directory

    read_plist

    initialize_catalog
    process_tracks

    copy_catalog
  end

  private
  def get_exported_file
    found = false

    until found
      @exported_file = ask("Location of Playlist [~/Desktop/usb/playlist.xml]")
      @exported_file = "~/Desktop/usb/playlist.xml" if @exported_file == ""
      @exported_file = File.expand_path(@exported_file) 

      if File.exists?(@exported_file)
        found = true
      else
        say "File #{@exported_file} does not exist", :red
      end
    end
  end

  def get_target_directory
    found = false

    until found
      @target_directory = ask("Location to which music should be copied [~/Desktop/usb]")
      @target_directory = "~/Desktop/usb/" if @target_directory == ""
      @target_directory += "/" unless ("/" == @target_directory[-1])

      @target_directory = File.expand_path(@target_directory) 

      if File.exists?(@target_directory)
        found = true
      else
        say "Directory #{@target_directory} does not exist", :red
      end
    end
  end

  def read_plist
    say "Reading #{@exported_file}", :green
    @export = Plist::parse_xml(@exported_file)
    @tracks = @export["Tracks"]
  end

  def initialize_catalog
    @catalog = {}
  end

  def process_tracks
    @tracks.each do |id, info|
      add_track_to_catalog(info)
    end
  end

  def add_track_to_catalog(info)
    name = clean_string(info["Name"])
    album = clean_string(info["Album"][0,25])
    genre = clean_string(info["Genre"][0,20])
    track_number = info["Track Number"]
    file_uri = URI(info["Location"])

    original_file = URI.decode(file_uri.path)
    original_file =~ /.*\.(.*)/
    file_type = $1

    @catalog[genre] ||= {}
    @catalog[genre][album] ||= []

    target_name = "%02d-#{name}.#{file_type}" % track_number
    @catalog[genre][album] << {:name => target_name, :file => original_file}
  end

  def clean_string(s)
    s.gsub(/\/|\(|\)/, '_')
  end

  def copy_catalog
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
            unless options.debug?
              FileUtils.copy_file(source, full_destination)
            end
          else
            puts "    *** Source does not exist"
          end
        end
      end
    end
  end
end

PlaylistExporter.start
