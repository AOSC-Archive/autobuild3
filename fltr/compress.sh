abrequire fileenum
abreqexe gzip
fltr_compress__process(){
	[ "$ABCOMPRESS" = "" ] && return 0
	gzip "$*"
}
fltr_compress(){
	for i in usr/share/man usr/share/info opt/*/share/man opt/*/man opt/*/share/info opt/*/info usr/man usr/info
	do
		[ -d $i ] || continue
		pushd $i >/dev/null
		fileenum "fltr_compress__process {}"
		popd >/dev/null
	done
}

export ABFLTRS="$ABFLTRS compress"
