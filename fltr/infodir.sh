fltr_infodir(){
	if [ -f usr/share/info/dir ]
	then
		rm usr/share/info/dir
	else
		true
	fi
}

export ABFLTRS="$ABFLTRS infodir"
