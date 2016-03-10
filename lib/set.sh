#!/bin/bash
##A simple stringset impl using dicts
##@copyright CC0

## INIT
# create a global set
abset_new(){ declare -gA "$1"; }
# create a local set
alias abset_loc='declare -A'
# helper
alias _abset_ab='declare -n __a="$1" __b="$2"'

## PRIMITIVES
# add opts to set (won't complain if already there)
# also handy for `union` (|)
abset_add(){ declare -n __set="$1"; local __idx; for __idx in "${@:1}"; do __set["$__idx"]=1; done; }
# del opts from set (won't complain if not found)
# also handy for `difference` (-)
abset_del(){ local __a=("${@:1}"); __a=("${a[@]/#/$1\[}"); unset "${a[@]/%/\]}"; }

## Set-ish OP
## Convention: returned values stored in _setRet{set}.
# union (|, +)       -- TODO: trivial.
abset_or(){ :; }
# difference (-) -- TODO: trivial.
abset_dif(){ :; }
# symdiff (^)     -- TODO: chained ver
abset_xor(){
	_abset_ab
	abset_new _setRet
	abset_loc __c
	abset_add __c "${!__a[@]}"
	abset_add _setRet "${!__b[@]}"
	abset_del __c "${!__b[@]}"
	abset_del _setRet "${!__a[@]}"
	abset_add _setRet "${!c[@]}"
}
# intersection (&) -- TODO: ditto.
abset_and(){
	_abset_ab
	
}

## CMP op
# a == b?
abset_eq(){
	_abset_ab
	[[ "${!__a[@]}" == "${!__b[@]}" ]]
}
# a != b?
abset_ne(){ _abset_ab; [[ "${!__a[@]}" != "${!__b[@]}" ]]; }
# a <= b? (subset)
abset_le(){
	_abset_ab
	abset_loc __c
	abset_add __c "${!__a[@]}" "${!__b[@]}"
	[[ "${!__b[@]}" == "${!__c[@]}" ]]
}
# a >= b?
abset_ge(){ abset_le "$2" "$1"; }
# a < b?  (true subset)
abset_lt(){ abset_le "$1" "$2" && abset_ne "$1" "$2"; }
# a > b?
abset_gt(){ abset_lt "$2" "$1"; }

## MISC
# dump a set into an array (useless)
abset_arr(){ declare -n __set="$1" __arr="$2"; __arr=("${!__set[@]}"); }
