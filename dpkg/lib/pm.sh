abreqexe dpkg dpkg-deb dpkg-query
pm_whoprov(){
	dpkg-query -S $1 2> /dev/null
}
