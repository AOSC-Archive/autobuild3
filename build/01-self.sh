abtrylib arch || ablibret

build_self_probe(){
	[ -f `arch_findfile build` ]
}

build_self_build(){
	arch_loadfile build
	cd $SRCDIR
}

ABBUILDS+=' self'
# Soga...
