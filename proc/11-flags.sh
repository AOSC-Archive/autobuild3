if bool $NOLTO; then
    export CPPFLAGS="-D_FORTIFY_SOURCE=2 -O2" 
    export CFLAGS="-march=x86-64 -mtune=core2 -O2 -pipe -fstack-protector-strong --param=ssp-buffer-size=4 -msse2 -msse3 -fPIC -fno-lto -fuse-linker-plugin -Wno-error" 
    export CXXFLAGS="-march=x86-64 -mtune=core2 -O2 -pipe -fstack-protector-strong --param=ssp-buffer-size=4 -msse2 -msse3 -fPIC -fno-lto -fuse-linker-plugin -Wno-error" 
    export LDFLAGS="-Wl,-O1,--sort-common,--as-needed,-z,relro -fPIC -fno-lto -fuse-linker-plugin" 
else
    export CPPFLAGS="-D_FORTIFY_SOURCE=2 -O2"
    export CFLAGS="-march=x86-64 -mtune=core2 -O2 -pipe -fstack-protector-strong --param=ssp-buffer-size=4 -msse2 -msse3 -fPIC -flto -fuse-linker-plugin -Wno-error"
    export CXXFLAGS="-march=x86-64 -mtune=core2 -O2 -pipe -fstack-protector-strong --param=ssp-buffer-size=4 -msse2 -msse3 -fPIC -flto -fuse-linker-plugin -Wno-error"
    export LDFLAGS="-Wl,-O1,--sort-common,--as-needed,-z,relro -fPIC -flto -fuse-linker-plugin"
fi
