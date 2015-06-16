if bool loading_build; then
	BUILD=armv7a-hardfloat-linux-gnueabi
fi

if bool loading_host; then
	HOST=armv7a-hardfloat-linux-gnueabi
	[ "$CROSS" ] && HOSTTOOLPREFIX=/opt/abcross/armel/bin/armv7a-hardfloat-linux-gnueabi
	CFLAGS_COMMON_ARCH='-march=armv7-a -mtune=cortex-a7 -mfpu=neon -mfloat-abi=hard'
fi

