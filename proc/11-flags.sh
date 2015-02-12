if bool $NOLTO; then
    export CPPFLAGS="$CPPFLAGS_NOLTO" 
    export CFLAGS="$CFLAGS_NOLTO"
    export CXXFLAGS="$CXXFLAGS_NOLTO"
    export LDFLAGS="$LDFLAGS_NOLTO"
else
    export CPPFLAGS="$CPPFLAGS_LTO"
    export CFLAGS="$CFLAGS_LTO"
    export CXXFLAGS="$CXXFLAGS_LTO"
    export LDFLAGS="$LDFLAGS_LTO"
fi
