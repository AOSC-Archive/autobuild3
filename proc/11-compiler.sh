# Compiler configuration.
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
