#!/bin/bash - 

. /app/lib/common.sh

CHECK_BIN "wget"
CHECK_BIN "unzip"
CHECK_BIN "uwsgi"

DIR=/var/www/PodcastGenerator-master

if [[ ! -d $DIR ]]; then
	MSG "Downloading podcastgen..."
	wget -O /tmp/podcastgen.zip https://sourceforge.net/projects/podcastgen/files/latest/download
	[[ $? -eq 0 ]] || { ERR "Failed to download podcastgen, aborting."; exit 1; }
	unzip -o -d /var/www /tmp/podcastgen.zip
	ls -la /var/www
	[[ -d $DIR ]] || { ERR "Directory $DIR does not exist, aborting."; exit 1; }
	chown -R www-data:www-data /var/www/
fi

MSG "Serving site..."

exec "$@"
