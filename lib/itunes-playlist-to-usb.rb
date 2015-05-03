$:.unshift File.dirname(__FILE__)
$:.unshift File.join(File.dirname(__FILE__), '/itunes-playlist-to-usb')

require 'byebug'
require 'yaml'

### LOAD SETTINGS #############################################################
base_dir = File.expand_path(File.join(File.dirname(__FILE__), "../"))
settings_paths = [
  File.join(base_dir, "etc/settings.yml"),
  File.expand_path("~/.itunes-playlist-to-usb"),
]

settings_paths.each do |s|
  break if defined?(SETTINGS)
  SETTINGS = YAML.load_file(s) if File.exist? s
end

CODECS = YAML.load_file(File.join(base_dir, "etc/codecs.yml")) unless defined?(CODECS)
###############################################################################

require 'process'
require 'playlist'
require 'track'
require 'file'
require 'library_path'
