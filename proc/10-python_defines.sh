#!/bin/bash
##python_defines: Dynamic Python version declaration for installation scripts
##@copyright GPL-2.0+
export ABPY2VER="$(python2 -c 'import sys; print("%s.%s" %sys.version_info[0:2])')"
export ABPY2SHORTVER="$(python2 -c 'import sys; print("%s%s" %sys.version_info[0:2])')"
export ABPY3VER="$(python3 -c 'import sys; print("%s.%s" %sys.version_info[0:2])')"
export ABPY3SHORTVER="$(python3 -c 'import sys; print("%s%s" %sys.version_info[0:2])')"
