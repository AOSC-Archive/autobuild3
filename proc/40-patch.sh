abrequire arch

if [ ! -f .patch ]
then
	if arch_loadfile patch
	then
		touch .patch
	elif [ -f autobuild/patches/series ]
	then
		for i in `cat autobuild/patches/series`; do
			patch -Np1 -i autobuild/patches/$i
			# Some patches are not -Np1 prefixed, keep in mind.
		done
		if [ ${ABTYPE} = "autotools" ]; then
			if [ -x $SRC/autogen.sh ]; then
				NOCONFIGURE=1 ./autogen.sh
			else
				autoreconf -fi
			fi
		fi
		touch .patch
	elif [ -d autobuild/patches ]
	then
		for i in autobuild/patches/*.{patch,diff}; do
			patch -Np1 -i $i
		done
		if [ ${ABTYPE} = "autotools" ]; then
			if [ -x $SRC/autogen.sh ]; then
				NOCONFIGURE=1 ./autogen.sh
			else
				autoreconf -fi
			fi
		fi
		touch .patch
	fi

fi
