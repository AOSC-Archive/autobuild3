# Compiler configuration.

# Wrapper TODO: accept $0 detection by checking ${HOSTTOOLPREFIX/abcross/abwrap}.
if [ -z "$CROSS" ]; then
	if [ -e /usr/bin/gcc-multilib-wrapper ]; then
		if bool $USECLANG; then
			export CC=/usr/bin/clang CXX=/usr/bin/clang++
		else
			export CC=/usr/bin/gcc-multilib-wrapper CXX=/usr/bin/g++-multilib-wrapper
		fi
	else
		if bool $USECLANG; then
			export CC=/usr/bin/clang CXX=/usr/bin/clang++
		else
			export CC=/usr/bin/gcc CXX=/usr/bin/g++
		fi
	fi
fi
