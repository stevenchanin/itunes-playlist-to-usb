#!/usr/bin/env ruby

require 'rubygems'
require 'thor'
require 'plist'
require 'uri'
require 'fileutils'

require File.join(File.dirname(__FILE__), "../lib/itunes-playlist-to-usb")

settings.paths = [
  File.expand_path("~/.itunes-playlist-to-usb"),
  File.join(File.dirname(__FILE__), "./etc/settings.yml"
]

settings.paths.each do |s|
  SETTINGS = YAML.load_file if File.exist?(s)
end
CODEC = YAML.load_file(File.join(File.dirname(__FILE__), "./etc/codecs.yml"))[SETTINGS["codec"]

PlaylistExporter.start
