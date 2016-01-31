#!/bin/bash
##proc/compiler: A weird and broken way to select the compilers
##@copyright GPL-2.0+

# Wrapper TODO: accept $0 detection by checking ${HOSTTOOLPREFIX/abcross/abwrap}.
if [ -z "$CROSS" ]; then
	if [ -d /opt/pseudo-multilib/bin ]; then
		export PATH="/opt/pseudo-multilib/bin:$PATH"
	else
		if bool $USECLANG; then
			export CC=clang CXX=clang++ OBJC=clang OBJCXX=clang++
		else
			export CC=gcc CXX=g++ OBJC=clang OBJCXX=clang++
		fi
	fi
fi
