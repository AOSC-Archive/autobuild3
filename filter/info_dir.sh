#!/bin/bash
##filter/infodir.sh: Kills the info directory
##@copyright GPL-2.0+
filter_infodir(){
	if [ -f usr/share/info/dir ]
	then
		rm usr/share/info/dir
	fi
}

ABFILTERS+=("infodir")
