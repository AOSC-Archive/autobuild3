build_self_probe(){
	[ -f `arch_filefind build` ]
}

build_self_build(){
	. `arch_filefind build`
	cd $SRCDIR
}

export ABBUILDS="$ABBUILDS self"
# Soga...
