#!/bin/bash
##proc/filter.sh: Now we run the filters
##@copyright GPL-2.0+
recsr $AB/filter/*.sh

pushd $PKGDIR > /dev/null || return

for ii in $ABFILTERS; do
	filter_$ii
done

popd > /dev/null
