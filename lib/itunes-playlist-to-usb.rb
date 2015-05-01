$:.unshift File.dirname(__FILE__)
$:.unshift File.join(File.dirname(__FILE__), '/itunes-playlist-to-usb')

require 'byebug'
require 'yaml'

require 'convert'
require 'playlist_manager'
require 'track'
