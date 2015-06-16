if bool loading_build; then
	BUILD=x86_64-unknown-linux-gnu
fi
if bool loading_host; then
	CFLAGS_COMMON_ARCH='-march=x86-64 -mtune=core2 -msse -msse2 -msse3 '
fi
