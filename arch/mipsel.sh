# FIXME: Loongson workaround added as suggested by biergaizi, do this break anything?
CFLAGS_COMMON_ARCH='-march=mips3 -mtune=loongson2f -mabi=n32 -Wa,-mfix-loongson2f-nop '
