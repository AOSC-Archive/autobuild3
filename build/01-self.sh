build_self_probe(){
	[ -f autobuild/build ]
}

build_self_build(){
	. autobuild/build 
	cd $SRCDIR
}

export ABBUILDS="$ABBUILDS self"
# Soga...