#!/bin/bash
## Datatype Compatibility for the worst human beings.

for _arr_v in $(<"$AB"/exportvars/.arrays); do
	if [[ $(typeof "$arr_v") != *a* ]]; then
		IFS=$' \t\n' read -d '' -ra "$arr_v" <<< "${!arr_v}"
	fi
done
