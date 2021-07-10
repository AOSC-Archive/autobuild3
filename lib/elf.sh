#!/bin/bash
##  strip routine adapted from ArchLinux's makepkg script.

#   makepkg - make packages compatible for use with pacman
#   @configure_input@
#
#   Copyright (c) 2006-2015 Pacman Development Team <pacman-dev@archlinux.org>
#   Copyright (c) 2002-2006 by Judd Vinet <jvinet@zeroflux.org>
#   Copyright (c) 2005 by Aurelien Foret <orelien@chez.com>
#   Copyright (c) 2006 by Miklos Vajna <vmiklos@frugalware.org>
#   Copyright (c) 2005 by Christian Hamar <krics@linuxforum.hu>
#   Copyright (c) 2006 by Alex Smith <alex@alex-smith.me.uk>
#   Copyright (c) 2006 by Andras Voroskoi <voroskoi@frugalware.org>
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Adapted for splitting debug symbols from ELF
# ~cth451, Jan 20 2021

abreqexe strip file objcopy install

elf_iself()
{
	file -F $'\n' "$1" | grep -Eq '^ (\w+ (ELF|thin archive|current ar)|(ELF|thin archive|current ar))'
}

# $1 = path to ELF
# Returns: string formed SHA1
elf_buildid_sha1()
{
	file -b "$1" | grep -oP '(?<=BuildID\[sha1\]=)[0-9a-f]+'
}

# $1 = path to ELF
elf_has_debug()
{
	objdump -h "$1" | grep -qP '[0-9]+ +\.debug_'
}

# $1 = symbol file to install
# $2 = BUILD_ID of this ELF in sha1
# $3 = PKGDIR
# This function may be manually called by 'beyond' for packages that generates their own symbols.
elf_install_symfile()
{
	BUILD_ID="$2"
	SYM_INSTDIR="$3"/usr/lib/debug/.build-id/${BUILD_ID:0:2}
	install -Dm644 -o root -g root "$1" "${SYM_INSTDIR}/${BUILD_ID:2}".debug
}

# $1 = path to ELF to strip
elf_strip()
{
	case "$(readelf -h $1)" in
		*Type:*'DYN (Shared object file)'*)
			strip --strip-unneeded --remove-section=.comment --remove-section=.note $1 ;;
		*Type:*'EXEC (Executable file)'*)
			strip --strip-all --remove-section=.comment --remove-section=.note $1 ;;
		*Type:*'REL (Relocatable file)'*)
			case "$1" in
				*.ko)
					strip --strip-unneeded --remove-section=.comment --remove-section=.note $1 ;;
				*)
					strip --strip-debug --enable-deterministic-archives --remove-section=.comment --remove-section=.note $1 ;;
			esac ;;
		*)
			true ;;
	esac
}

# $1 = path to original ELF
# $2 = PKGDIR
# Copies symbols of an ELF $1 to $2/usr/lib/debug/.build-id/BU/ILD_ID_OF_ELF_IN_SHA1.debug
elf_copydbg()
{
	file -F $'\n' "$1" | grep -Eq '^ (thin archive|current ar)' \
		&& abinfo "Skipped $1 as it is a static library." && return 0
	case "$(readelf -h $1)" in
		*Type:*'DYN (Shared object file)'*)
			;&
		*Type:*'EXEC (Executable file)'*)
			;&
		*Type:*'REL (Relocatable file)'*)
			BUILD_ID=$(elf_buildid_sha1 "$1")
			if (( $? )); then
				abicu "$1 does not contain a BuildID in SHA1!"
				return 1
			fi
			if ! elf_has_debug "$1"; then
				abwarn "Skipped $1 as it does not contain debug symbols."
				return 0
			fi
			TMP_SYMFILE=$(mktemp ab3_elf_sym.XXXXXXXX)
			objcopy --only-keep-debug "$1" "${TMP_SYMFILE}" 
			elf_install_symfile "${TMP_SYMFILE}" "$BUILD_ID" "$2"
			rm -f "${TMP_SYMFILE}"
			;;
		*)
			true ;;
	esac
}

