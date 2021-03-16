#!/bin/bash
##mter: Check maintainer information.
##@copyright GPL-2.0+
if [[ "$MTER" = "Null Packager <null@aosc.xyz>" ]]; then
	aberr "QA (E311): Maintainer information not set." | tee -a "$SRCDIR"/abqaerr.log
fi
