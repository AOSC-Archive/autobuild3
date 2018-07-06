#!/bin/bash
##proc/licenses.sh: SPDX-compatible license processing.
##@copyright GPL-2.0+
# _license_atom: _license [ " WITH " _exception ]
# TODO: Multiple exceptions, Unknown exceptions

set_opt nullglob
((${#_license_files[@]})) || _license_files=( {COPYING,LICENSE}* )
rec_opt nullglob

if ! [ -r /usr/share/spdx-licenses/exceptions ]; then
	abwarn detailed license processing skipped due to missing files.
	mkdir -p "$PKGDIR/usr/share/doc/$PKGNAME"
	((${#_license_files[@]})) && cp --no-preserve=mode "${_license_files[@]}" "$PKGDIR/usr/share/doc/$PKGNAME"
fi

declare -A _license_exception
while IFS=$'\t' read LicenseGlob ExceptionID discard; do
	[[ LicenseGlob != \#* ]] || continue
	_license_exception[ "$ExceptionID" ]="$LicenseGlob"
done < /usr/share/spdx-licenses/exception

_license_has_custom=0
for _license in "${PKGLICENSES[@]}"; do
	_exception="${_license/#* WITH}"
	_license="${_license/% WITH *}"
	if [ -e /usr/share/spdx-licenses/"$_license".txt ]; then
		[[ $_license == ${_license_exception["$_exception"]} ]] ||
		abwarn "$_license doesn't match $_exception glob ${_license_exception["$_exception"]}"
	else
		_license_has_custom=1
	fi
done

((_license_has_custom)) || return

_license_files_real=()
for _license_f in "${_license_files[@]}"; do
	for _license_o in /usr/share/spdx-licenses/*.txt; do
		if cmp -s "$_license_f" "$_license_o"; then
			PKGLICENSES+=("${_license_o%.txt}")
		else
			_license_files_real+=("$_license_f")
		fi
	done
done

declare -A _license_tmp_dedup
for _license_tmp in "${PKGLICENSES[@]}"; do _license_tmp_dedup["$_license_tmp"]=1; done
PKGLICENSES=("${!_license_tmp_dedup[@]}")
unset _license_tmp_dedup _license_tmp _license_f _license_o

((${#_license_files_real[@]})) && cp --no-preserve=mode "${_license_files[@]}" "$PKGDIR/usr/share/doc/$PKGNAME"
