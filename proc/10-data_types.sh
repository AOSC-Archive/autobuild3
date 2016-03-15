#!/bin/bash
## Datatype Compatibility for the worst human beings.

# todo refactor
_abinternal_array=(
	ABBUILDS
	ABFILTERS
	filter_elf_dep_libs
)

for _arr_v in $(<"$AB"/exportvars/*-array) "${_abinternal_array[@]}"; do
	if [[ $(typeof "$arr_v") != *a* ]]; then
		IFS=$' \t\n' read -d '' -ra "$arr_v" <<< "${!arr_v}"
	fi
done
