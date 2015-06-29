filter_infodir(){
	if [ -f usr/share/info/dir ]
	then
		rm usr/share/info/dir
	fi
}

export ABFILTERS="$ABFILTERS infodir"
