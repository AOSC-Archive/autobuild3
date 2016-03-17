#!/bin/bash
## Datatype Compatibility for the worst human beings.

# todo refactor
_abinternal_array=(
	ABBUILDS
	ABFILTERS
	ABELFFILTERS
	ABPACKAGE
	DPKGDEBCOMP
	PM_ROOTPARAM
	filter_elf_dep_libs
)

for _arr_v in $(cat "$AB"/exportvars/*-array) "${_abinternal_array[@]}"; do
	if [[ $(typeof "$_arr_v") != *a* ]]; then
		IFS=$' \t\n' read -d '' -ra "$_arr_v" <<< "${!_arr_v}"
		abwarn "Pia! Coerced $_arr_v to array."
	fi
done
