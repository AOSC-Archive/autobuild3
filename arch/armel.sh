if bool loading_build; then
	BUILD=armv7a-hardfloat-linux-gnueabi
fi

if bool loading_host; then
	HOST=armv7a-hardfloat-linux-gnueabi
	[ "$CROSS" ] && HOSTTOOLPREFIX=/opt/abcross/armel/bin/armv7a-hardfloat-linux-gnueabi
	[ "$CROSS" ] && LDFLAGS_COMMON_ARCH='-Wl,-rpath -Wl,/usr/lib -Wl,-rpath-link -Wl,/var/ab/cross-root/armel/usr/lib -L/var/ab/cross-root/armel/usr/lib'
	CFLAGS_COMMON_ARCH='-march=armv7-a -mtune=cortex-a7 -mfpu=neon -mfloat-abi=hard'
fi

