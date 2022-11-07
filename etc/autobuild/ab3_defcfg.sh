#!/bin/bash-
##Autobuild default config file
##@copyright CC0

# Environmental Settings
# Avoid setting TMPDIR as tmpfs mount points.
TMPDIR="$SRCDIR"

# Misc building flags
ABARCHIVE=autobuild-aoscarchive	# Archive program
ABSHADOW=yes			# Shall shadow builds be performed by default?
NOLTO=no			# Enable LTO by default.
USECLANG=no			# Are we using clang?
NOSTATIC=yes			# Want those big fat static libraries?
ABCLEAN=yes			# Clean before build?
NOLIBTOOL=yes			# Hug pkg-config and CMake configurations?
ABCONFIGHACK=yes		# Use config.{sub,guess} replacement for newer architectures?
NOCARGOAUDIT=no			# Audit Cargo (Rust) dependencies?
NONPMAUDIT=no			# Audit NPM dependencies?
ABUSECMAKEBUILD=yes		# Use cmake build for cmake* ABTYPEs?
ABSPLITDBG=yes			# Split out debug package containing symbols (-dbg)?

# Strict Autotools option checking?
AUTOTOOLS_STRICT=yes

# Parallelism, the default value is an equation depending on the number of processors.
# $ABTHREADS will take any integer larger than 0.
ABTHREADS=$(( $(nproc) + 1))
ABMANCOMPRESS=1
ABINFOCOMPRESS=1
ABELFDEP=0	# Guess dependencies from ldd?
ABSTRIP=1	# Should ELF be stripped off debug and unneeded symbols?

# Use -O3 instead?
AB_FLAGS_O3=0

# Use -Os instead?
AB_FLAGS_OS=0

# PIC and PIE are enabled by GCC/LD specs.
AB_FLAGS_SSP=1
AB_FLAGS_SCP=1
AB_FLAGS_RRO=1
AB_FLAGS_NOW=1
AB_FLAGS_FTF=1

# Fallback for Clang which does not support specs.
AB_FLAGS_PIC=1
AB_FLAGS_PIE=1

# Hardening specs?
AB_FLAGS_SPECS=1

# Enable table-based thread cancellation.
AB_FLAGS_EXC=1

AB_SAN_ADD=0
AB_SAN_THR=0
AB_SAN_LEK=0

# Use BFD LD?
AB_LD_BFD=0

##OS Directory Tree
# Built-in variables for AOSC OS directory tree.
# Will be updated. Therefore not part of conffiles.
#
PREFIX="/usr"
BINDIR="/usr/bin"
LIBDIR="/usr/lib"
SYSCONF="/etc"
CONFD="/etc/conf.d"
ETCDEF="/etc/default"
LDSOCONF="/etc/ld.so.conf.d"
FCCONF="/etc/fonts"
LOGROT="/etc/logrotate.d"
CROND="/etc/cron.d"
SKELDIR="/etc/skel"
BINFMTD="/usr/lib/binfmt.d"
X11CONF="/etc/X11/xorg.conf.d"
STATDIR="/var"
INCLUDE="/usr/include"
BOOTDIR="/boot"
LIBEXEC="/usr/libexec"
MANDIR="/usr/share/man"
FDOAPP="/usr/share/applications"
FDOICO="/usr/share/icons"
FONTDIR="/usr/share/fonts"
USRSRC="/usr/src"
VARLIB="/var/lib"
RUNDIR="/run"
DOCDIR="/usr/share/doc"
LICDIR="/usr/share/doc/licenses"
SYDDIR="/usr/lib/systemd/system"
SYDSCR="/usr/lib/systemd/scripts"
TMPFILE="/usr/lib/tmpfiles.d"
PAMDIR="/etc/pam.d"
JAVAMOD="/usr/share/java"
JAVAHOME="/usr/lib/java"
GTKDOC="/usr/share/gtk-doc"
GSCHEMAS="/usr/share/glib-2.0/schemas"
THEMES="/usr/share/themes"
BASHCOMP="/usr/share/bash-completion"
ZSHCOMP="/usr/share/zsh-completion"
PROFILED="/etc/profile.d"
LOCALES="/usr/share/locales"
VIMDIR="/usr/share/vim"
QT4DIR="/usr/lib/qt4"
QT5DIR="/usr/lib/qt5"
QT4BIN="/usr/lib/qt4/bin"
QT5BIN="/usr/lib/qt5/bin"

##OS basic configuration flags
AUTOTOOLS_DEF="""
	--prefix=$PREFIX
	--sysconfdir=$SYSCONF
	--localstatedir=$STATDIR
	--libdir=$LIBDIR
	--bindir=$BINDIR
	--sbindir=$BINDIR
	--mandir=$MANDIR
"""
CMAKE_DEF="""
	-DCMAKE_INSTALL_PREFIX=$PREFIX
	-DCMAKE_BUILD_TYPE=RelWithDebInfo
	-DCMAKE_INSTALL_LIBDIR=lib
	-DLIB_INSTALL_DIR=lib
	-DSYSCONF_INSTALL_DIR=$SYSCONF
	-DCMAKE_INSTALL_SBINDIR=$BINDIR
	-DCMAKE_SKIP_RPATH=ON
	-DCMAKE_VERBOSE_MAKEFILE=ON
"""
MESON_DEF="--prefix=$PREFIX --sbindir=$BINDIR"
WAF_DEF="--prefix=$PREFIX --configdir=$SYSCONF --libdir=$LIBDIR"
QTPROJ_DEF="PREFIX=$PREFIX LIBDIR=/usr/lib CONFIG+=force_debug_info"
MAKE_INSTALL_DEF="PREFIX=$PREFIX BINDIR=$BINDIR \
SBINDIR=$BINDIR LIBDIR=$LIBDIR INCDIR=$INCLUDE MANDIR=$MANDIR \
prefix=$PREFIX bindir=$BINDIR sbindir=$BINDIR libdir=$LIBDIR \
incdir=$INCLUDE mandir=$MANDIR"

# AUTOTOOLS related
RECONF=yes

##Packaging info
ABQA=yes
ABINSTALL="dpkg"

# Golang default build flags | Adapted from Arch Linux's Go package guildline.
GOFLAGS+=" -mod=readonly"  # Ensure module files are not updated during building process.
GOFLAGS+=" -trimpath"      # Required for eproducible build.
GOFLAGS+=" -modcacherw"    # Ensures that go modules creates a write-able path.
GOFLAGS+=" -buildmode=pie" # Hardening binary.

# Old, default.
[[ -d "$AB"/etc/autobuild/defaults ]] && recsr "$AB"/etc/autobuild/defaults/*!(.dpkg*|dist)

. "$AB"/etc/autobuild/ab3cfg.sh
[[ -d "$AB"/etc/autobuild/ab3cfg.d ]] && recsr "$AB"/etc/autobuild/ab3cfg.d/*!(.dpkg*|dist)

if bool $ABSTAGE2; then
	abwarn "Autobuild3 running in stage2 mode ..."
	NOCARGOAUDIT=yes
	NONPMAUDIT=yes
	ABSPLITDBG=no
fi

abdetectarch() {
	type dpkg >/dev/null 2>&1 && dpkg --print-architecture || ( echo "[!!!] Cannot find dpkg executable, exiting ..." && exit 1 )
}

abassigngroup() {
	basename -a $(grep -lr "$1" "$AB/sets/arch_groups/")
}

((AB_COMPAT > 1)) || : "${ABBUILD:=$ARCH}" "${ABHOST:=$CROSS}"
: "${ABBUILD:="$(abdetectarch)"}"  "${ABHOST:=$ABBUILD}" "${ABTARGET:=$ABHOST}"
ABHOST_GROUP="$(abassigngroup $ABHOST)"

unset -f abdetectarch abassigngroup
