#!/bin/bash
##python_defines: Dynamic Python version declaration for installation scripts
##@copyright GPL-2.0+
PY2VER="$(python2 -c 'import sys; print("%s.%s" %sys.version_info[0:2])')"
PY2SHORTVER="$(python2 -c 'import sys; print("%s%s" %sys.version_info[0:2])')"
PY3VER="$(python3 -c 'import sys; print("%s.%s" %sys.version_info[0:2])')"
PY3SHORTVER="$(python3 -c 'import sys; print("%s%s" %sys.version_info[0:2])')"
