#!/bin/bash
##A simple stringset impl using dicts
##@copyright CC0

## INIT
# create a global set
abset_new(){ declare -gA "$1"; }
# create a local set
alias abset_loc='declare -A'
# helper
alias _abset_AB='declare -n __A="$1" __B="$2"'

## PRIMITIVES
# add opts to set (won't complain if already there)
# also handy for `union` (|)
abset_add(){ declare -n __set="$1"; local __idx; for __idx in "${@:1}"; do __set["$__idx"]=1; done; }
# del opts from set (won't complain if not found)
# also handy for `difference` (-)
abset_del(){ declare -n __set="$1"; local __idx; for __idx in "${@:1}"; do unset '__set[$__idx]'; done; }

## Set-ish OP
## Convention: returned values stored in _setRet{set}.
# union (|, +)       -- TODO: trivial.
abset_or(){ :; }
# difference (-) -- TODO: trivial.
abset_dif(){ :; }
# symdiff (^)     -- TODO: chained ver
abset_xor(){
	_abset_AB
	abset_new _setRet
	abset_loc __C
	abset_add __C "${!__A[@]}"
	abset_add _setRet "${!__B[@]}"
	abset_del __C "${!__B[@]}"
	abset_del _setRet "${!__A[@]}"
	abset_add _setRet "${!__C[@]}"
}
# intersection (&) -- TODO: ditto.
abset_and(){
	_abset_AB
	abset_loc __C
	abset_add __C "${!__A[@]}" "${!__B[@]}"
	abset_xor "$1" "$2"
	abset_del __C "${!_setRet[@]}"
	abset_new _setRet
	abset_add _setRet "${!__C[@]}"
}

## CMP op
# a == b?
abset_eq(){
	_abset_AB
	[[ "${!__A[@]}" == "${!__B[@]}" ]]
}
# a != b?
abset_ne(){ _abset_AB; [[ "${!__A[@]}" != "${!__B[@]}" ]]; }
# a <= b? (subset)
abset_le(){
	_abset_AB
	abset_loc __C
	abset_add __C "${!__A[@]}" "${!__B[@]}"
	[[ "${!__B[@]}" == "${!__C[@]}" ]]
}
# a >= b?
abset_ge(){ abset_le "$2" "$1"; }
# a < b?  (true subset)
abset_lt(){ abset_le "$1" "$2" && abset_ne "$1" "$2"; }
# a > b?
abset_gt(){ abset_lt "$2" "$1"; }

## MISC
# dump a set into an array (useless)
abset_arr(){ declare -n __set="$1" __Arr="$2"; __Arr=("${!__set[@]}"); }
