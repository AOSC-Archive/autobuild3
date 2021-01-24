#!/bin/bash
##filter/elf/splitdbg.sh: Saves a copy of debug symbols around
##@copyright GPL-2.0+

# Note: This must be done before strip
abrequire elf

filter_elf_splitdbg_pre()
{
	bool $ABSTRIP || return 0
	bool $ABSPLITDBG || return 0
	abdbg "Creating debug symbol install directory: $SYMDIR"
	mkdir -p "$SYMDIR"
}

filter_elf_splitdbg()
{
	# ABSTRIP = false => Don't split
	bool $ABSTRIP || return 0
	# ABSTRIP = true and ABSPLITDBG = false => Don't split
	bool $ABSPLITDBG || return 0
	abdbg "Saving debug symbol of $1 .."
	elf_copydbg "$1" "${SYMDIR}"
}

export ABELFFILTERS="$ABELFFILTERS splitdbg"
