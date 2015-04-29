if bool $CROSS; then
    target_arch=$CROSS
else
    target_arch=$ARCH
fi
for i in CFLAGS_LTO CFLAGS_NOLTO CXXFLAGS_LTO CXXFLAGS_NOLTO \
         LDFLAGS_LTO LDFLAGS_NOLTO CPPFLAGS_LTO CPPFLAGS_NOLTO
do
    export $i="`cat $AB/arch/$target_arch/$i`"
done

if bool $USECLANG; then
    if bool $NOLTO; then
        export CPPFLAGS="$CPPFLAGS_CLANG_NOLTO" 
        export CFLAGS="$CFLAGS_CLANG_NOLTO"
        export CXXFLAGS="$CXXFLAGS_CLANG_NOLTO"
        export LDFLAGS="$LDFLAGS_CLANG_NOLTO"
    else
        export CPPFLAGS="$CPPFLAGS_CLANG_LTO"
        export CFLAGS="$CFLAGS_CLANG_LTO"
        export CXXFLAGS="$CXXFLAGS_CLANG_LTO"
        export LDFLAGS="$LDFLAGS_CLANG_LTO"
    fi
else
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
fi
