fltr_infodir(){
  if [ -d usr/share/info/dir ]
  then
    rm usr/share/info/dir
  else
    true
  fi
}
export ABFLTRS="$ABFLTRS infodir"
