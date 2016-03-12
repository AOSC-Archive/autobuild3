#!/bin/bash-
##Autobuild default config file
##@copyright CC0

##Misc building flags
ABARCHIVE=autobuild-aoscarchive # Archive program
ABSHADOW=yes  # Shall shadow builds be performed by default?
NOLTO=yes     # Shall we use LTO?
USECLANG=no   # Are we using clang?
NOSTATIC=yes  # Want those big fat static libraries?
ABCLEAN=yes   # Clean before build
NOLIBTOOL=yes # Hug pkg-config and CMake configurations?

# Parallelism, the default value is an equation depending on the number of processors.
# $ABTHREADS will take any integer larger than 0.
ABTHREADS=$(( $(nproc) + 1))
ABMANCOMPRESS=no
ABELFDEP=no   # Guess dependencies from ldd?
ABSTRIP=yes   # Strip off some symbols?

##Hardening flags
# Work in progress: factor hardening-related flags into options
# Parameters that are likely to cause trouble.
AB_FLAGS_PIC=1
AB_FLAGS_PIE=1
AB_FLAGS_SSP=1
AB_FLAGS_RRO=1
AB_FLAGS_NOW=1
AB_FLAGS_FTF=1

##OS Directory Tree
# Built-in variables for OS3 directory tree.
# Will be updated. Therefore not part of conffiles.
#
# COPYLEFT TO WHOEVER NEEDS IT.
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
TMPDIR="/tmp"
LIBEXEC="/usr/libexec"
MANDIR="/usr/share/man"
FDOAPP="/usr/share/applications"
FDOICO="/usr/share/icons"
FONTDIR="/usr/share/fonts"
USRSRC="/usr/src"
VARLIB="/var/lib"
RUNDIR="/var/run"
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
AUTOTOOLS_DEF="--prefix=$PREFIX --sysconfdir=$SYSCONF --localstatedir=$STATDIR \
--libdir=$LIBDIR --bindir=$BINDIR --sbindir=$BINDIR --disable-option-checking \
--disable-static --enable-shared"
CMAKE_DEF="-DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release \
-DCMAKE_INSTALL_LIBDIR=lib -DLIB_INSTALL_DIR=lib -DSYSCONF_INSTALL_DIR=$SYSCONF \
-DCMAKE_SKIP_RPATH=ON"
WAF_DEF="--prefix=$PREFIX --configdir=$SYSCONF"
QTPROJ_DEF="PREFIX=$PREFIX"
MAKE_INSTALL_DEF="PREFIX=/usr BINDIR=/usr/bin SBINDIR=/usr/bin LIBDIR=/usr/lib"

# AUTOTOOLS related
RECONF=yes

##Packaging info
ABQA=yes
ABINSTALL="dpkg rpm"

# Old, default.
[[ -d "$AB"/etc/autobuild/defaults ]] && recsr "$AB"/etc/autobuild/defaults/*!(.dpkg*|dist)

. "$AB"/etc/autobuild/ab3cfg.sh
[[ -d "$AB"/etc/autobuild/ab3cfg.d ]] && recsr "$AB"/etc/autobuild/ab3cfg.d/*!(.dpkg*|dist)

((AB_COMPAT > 1)) || : "${ABBUILD:=$ARCH}" "${ABHOST:=$CROSS}"
: "${ABBUILD:="$(uname -m || echo amd64)"}"  "${ABHOST:=$ABBUILD}" "${ABTARGET:=$ABHOST}"
