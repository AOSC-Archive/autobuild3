#!/bin/bash
##mter: Check maintainer information.
##@copyright GPL-2.0+
if [[ "$MTER" = "Null Packager <null@aosc.xyz>" ]]; then
	abdie "QA (E311): Maintainer information not set."
