![Build Status Images](https://travis-ci.org/jonhiggs/itunes-playlist-to-usb.svg)

# ITunes Playlist To USB

## The Problem
Lots of cars now have USB interfaces to allow you to bring music with you. Those are great because you can buy a USB stick for much lower $/GB ($20 for 64gb = $0.31/gb) than by getting the storage space as part of an iPod ($149 for 16gb = $9.31/gb).

But I ran into a problem getting music copied over from my iTunes library onto the USB stick in a way that I could use it.

The first problem was that with a lot of music, I find it helpful to organize it by Genre and then by Album. That lets me quickly navigate to the album / songs I'm looking for. iTunes lets you drag (copy) music over to a USB stick, but then you just get all the files dropped into a single folder with no organization.

The second problem I ran into was that what ends up in that folder is a copy of the file where the name is whatever the underlying filename was originally created as, but that often includes all kinds of other information (junk) depending on what software was used to rip the song. Any cleanup you've done in iTunes to improve the name (or fix other meta data) is ignored.  You just get the original file name.

## Quick Setup

```bash
bundle install
cp etc/settings.yml.example etc/settings.yml && $EDITOR etc/settings.yml
bin/playlist_exporter process
```

## Setup

I tend to run ruby under RVM (https://rvm.io/) which installs bundler by default. If you don't have bundler installed, you will need to install it first

~~~~
$ gem install bundler
NOTE: you may need sudo to sudo the preceding command, depending on your installation directory and permissions
~~~~

once you've got bundler installed, then

~~~~
bundle install
~~~~

### Creating the Playlist File

![Select Playlist](https://github.com/stevenchanin/itunes-playlist-to-usb/raw/master/doc/images/iTunes_export1.png)  
![Initiate Export](https://github.com/stevenchanin/itunes-playlist-to-usb/raw/master/doc/images/iTunes_export2.png)  
![Save Export as XML file](https://github.com/stevenchanin/itunes-playlist-to-usb/raw/master/doc/images/iTunes_export_save.png)  

### Configuring the Settings

* Copy `etc/settings.yml.example` to `etc/settings.yml` or `~/.itunes-playlist-to-usb`
* Configure the settings file with your own preferences.

### Process your Playlist

~~~~
bin/playlist_exporter process
~~~~

### Options
if you ask for help from playlist_exporter, it will show you the options it accepts:

~~~~
Usage:
  playlist_exporter process

Options:
  -q, [--quiet], [--no-quiet]  # hide the progress bar
  -d, [--debug], [--no-debug]  # enable debugging

process the playlist file
~~~~

~~~~
Usage:
  playlist_exporter verify

Options:
  -q, [--quiet], [--no-quiet]  # hide the progress bar
  -d, [--debug], [--no-debug]  # enable debug mode.

verify the files files in library are valid
~~~~
