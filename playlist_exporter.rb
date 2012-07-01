#!/usr/bin/env ruby

require 'thor'
require 'plist'
require 'uri'
require 'fileutils'

class PlaylistExporter < Thor
  desc "process", "process playlist"
  def process
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
    name = info["Name"][0,20]
    album = info["Album"][0,20]
    genre = info["Genre"][0,20]
    track_number = info["Track Number"]
    file_uri = URI(info["Location"])

    original_file = URI.decode(file_uri.path)
    original_file =~ /.*\.(.*)/
    file_type = $1

    @catalog[genre] ||= {}
    @catalog[genre][album] ||= []
    @catalog[genre][album] << {:name => "#{track_number}-#{name}.#{file_type}", :file => original_file}
  end

  def copy_catalog
    @catalog.each do |genre, albums|
      puts "Genre: #{genre}"
      genre_path = "#{@target_directory}/#{genre}"
      FileUtils.mkdir(genre_path) unless File.exists?(genre_path)

      albums.each do |album, tracks|
        puts "  Album: #{album}"
        album_path = "#{@target_directory}/#{genre}/#{album}"
        FileUtils.mkdir(album_path) unless File.exists?(album_path)

        tracks.each do |track|
          full_destination = "#{@target_directory}/#{genre}/#{album}/#{track[:name]}"
          source = track[:file]

          puts "    Creating   : #{track[:name]}"
          puts "       source  : #{track[:file]}"

          if File.exists?(source)
            FileUtils.copy_file(source, full_destination)
          else
            puts "    *** Source does not exist"
          end
        end
      end
    end
  end
end

PlaylistExporter.start
