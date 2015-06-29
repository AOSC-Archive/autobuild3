# Porting: This is for the perl `rename'. For the util-linux one,
# do rename ' ' _ "$PKGDIR"/**. (Filetype not checked but symlink-safe)
# Testing: rpm/pack now supports basic escaping for spaces by double-
# quoting, so consider removing this someday.
# Packing: Breaks consistency in filenames.
find . -type d -o -type f | rename 's/ /_/g' ||
abinfo "Nothing to rename: find-rename pipe returned $?."
