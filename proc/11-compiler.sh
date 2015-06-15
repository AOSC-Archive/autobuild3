# Compiler configuration.

# Wrapper TODO: accept $0 detection by checking ${HOSTTOOLPREFIX/abcross/abwrap}.
if [ -z "$CROSS" ]; then
	if [ -d /opt/pseudo-multilib/bin ]; then
		export PATH="/opt/pseudo-multilib/bin:$PATH"
	else
		if bool $USECLANG; then
			export CC=/usr/bin/clang CXX=/usr/bin/clang++
		else
			export CC=/usr/bin/gcc CXX=/usr/bin/g++
		fi
	fi
fi
