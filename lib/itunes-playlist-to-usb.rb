$:.unshift File.dirname(__FILE__)
$:.unshift File.join(File.dirname(__FILE__), '/itunes-playlist-to-usb')

require 'byebug'
require 'fileutils'
require 'plist'
require 'rubygems'
require 'thor'
require 'uri'
require 'yaml'
require 'shellwords'

require 'playlist_exporter'
require 'convert'
require 'playlist_manager'
