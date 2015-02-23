# ITunes Playlist To USB

## The Problem
Lots of cars now have USB interfaces to allow you to bring music with you. Those are great because you can buy a USB stick for much lower $/GB ($20 for 64gb = $0.31/gb) than by getting the storage space as part of an iPod ($149 for 16gb = $9.31/gb).

But I ran into a problem getting music copied over from my iTunes library onto the USB stick in a way that I could use it.

The first problem was that with a lot of music, I find it helpful to organize it by Genre and then by Album.  That lets me quickly navigate to the album / songs I'm looking for.  iTunes lets you drag (copy) music over to a USB stick, but then you just get all the files dropped into a single folder with no organization.

The second problem I ran into was that what ends up in that folder is a copy of the file where the name is whatever the underlying filename was originally created as, but that often includes all kinds of other information (junk) depending on what software was used to rip the song. Any cleanup you've done in iTunes to improve the name (or fix other meta data) is ignored.  You just get the original file name.

## Usage
To use the playlist_exporter (this script), you:

### create a playlist(s) containing the songs / albums you want in iTunes

### export the playlist as XML

![Select Playlist](https://github.com/stevenchanin/itunes-playlist-to-usb/raw/master/doc/images/iTunes_export1.png)
![Initiate Export](https://github.com/stevenchanin/itunes-playlist-to-usb/raw/master/doc/images/iTunes_export2.png)

![Save Export as XML file](https://github.com/stevenchanin/itunes-playlist-to-usb/raw/master/doc/images/iTunes_export_save.png)

### run playlist_exporter
I tend to run ruby under RVM (https://rvm.io/) which installs bundler by default. If you don't have bundler installed, you will need to install it first

~~~~
$ gem install bundler
NOTE: you may need sudo to sudo the preceding command, depending on your installation directory and permissions
~~~~

once you've got bundler installed, then

~~~~
bundle install
ruby playlist_exporter.rb process
~~~~

the playlist_exporter will prompt you for where it should find:


* the XML file you exported your playlist to, and
* where it should write the music files to (this should be the path to your USB drive, or to a temp directory you will manually copy over)

![Run in Terminal](https://github.com/stevenchanin/itunes-playlist-to-usb/raw/master/doc/images/terminal.png)

and it will copy all the songs from the playlist onto the USB stick organized in a hierarchy of Genre and Album using the iTunes meta data.  It will generate new file names that are

~~~~
	<track number>-<song name from iTunes>
    #==> 9-Rock of Ages.mp3
~~~~

so you end up with a final result like:
![Final Result](https://github.com/stevenchanin/itunes-playlist-to-usb/raw/master/doc/images/final_result.png)

### Options
if you ask for help from playlist_exporter, it will show you the options it accepts:

~~~~
ruby playlist_exporter.rb help process 

Usage:
  playlist_exporter.rb process

Options:
  -v, [--verbose]  # running in verbose mode will also show each file as it's copied
  -d, [--debug]    # in debug mode files will not actually be copied
  -f, [--force]    # normally, copying a file is skipped if a file with the same name and size already exists in the destination. Force mode always copies.

process playlist
~~~~
