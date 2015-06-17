build_self_probe(){
	[ -f `arch_findfile build` ]
}

build_self_build(){
	arch_loadfile build
	cd $SRCDIR
}

export ABBUILDS="$ABBUILDS self"
# Soga...
