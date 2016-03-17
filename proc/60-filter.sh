#!/bin/bash
##proc/filter.sh: Now we run the filters
##@copyright GPL-2.0+
ABFILTERS=()
recsr "$AB/filter/*.sh"

pushd "$PKGDIR" > /dev/null || return

for ab_filter in "${ABFILTERS[@]}"; do
	"filter_$ab_filter"
done

popd > /dev/null
