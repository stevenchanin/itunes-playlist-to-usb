$:.unshift File.dirname(__FILE__)
$:.unshift File.join(File.dirname(__FILE__), '/itunes-playlist-to-usb')


require 'byebug'
require 'yaml'

### LOAD SETTINGS #############################################################
settings_paths = [
  File.join(File.dirname(__FILE__), "../etc/settings.yml"),
  File.expand_path("~/.itunes-playlist-to-usb"),
]

settings_paths.each { |s| SETTINGS = YAML.load_file(s) if File.exist?(s) }

#### PROGRESS BAR #############################################################

require 'convert'
require 'playlist_manager'
require 'track'
