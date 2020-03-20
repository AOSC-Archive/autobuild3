#!/bin/bash
##diag.sh: Print out formatted stacktrace information
##@copyright GPL-2.0+
diag_normalize_location() {
	# $1 source file location
	# $2 line number
	# Because we wrapped the script file, this is to map back the line number
	local normalized="${1/.wrap.sh/}"
	local lineno="${2}"
	if [ "$normalized" != "$1" ]; then
		lineno="$(($2 - 1))"
	fi
	echo "${normalized}:${lineno}"
}

diag_format_sample() {
	# $1 line number
	# $2 sample content
	local IFS=$'\n'
	local lineno="$1"
	for line in $2; do
		[ "$lineno" -eq "$1" ] && indicator='\e[1m>' || indicator=' '  # bold the first line
		printf "%s%4s | %s\e[0m\n" "${indicator}" "$lineno" "$line"
		lineno="$(($lineno+1))"
	done
}

diag_print_backtrace() {
	local _ret=$?
	echo -e "[\e[31mERROR\e[0m]: \e[1mScripting error detected. EMERGENCY DROP!\e[0m" >&2
	local depth="${#BASH_SOURCE[@]}"
	local buffer=""
	# Skip the first frame, the first frame should be the command specified on the command line (most likely what the user/packager typed in the shell)
	for ((i=1; i<depth; i++)); do
		local line="${BASH_LINENO[$((i-1))]}"
		local src="${BASH_SOURCE[i]}"
		# reverse order, most recent call last
		if [ $i -eq $(($depth-1)) ]; then
			buffer="\e[0mIn file included from \e[1m$(diag_normalize_location "${src}" "${line}")\n${buffer}"
		elif [ -z "$buffer" ]; then
			sample="$(sed -n "${line},$(($line+1))p;$(($line+2))q" "${src}")"  # grab the lines around the error
			# GCC style error message
			current_func=${FUNCNAME[$((i+1))]}
			[ "${current_func}" = "source" ] && current_func="(unknown)" || current_func="\`${current_func}'"
			buffer="$(diag_normalize_location "${src}" "${line}"): \e[91merror: \e[39mcommand exited with \e[93m$_ret\e[39m\n$(diag_format_sample "${line}" "${sample}")\n${buffer}"
			buffer="$(diag_normalize_location "${src}" "${line}"): \e[0mIn function \e[1m${current_func}:\n${buffer}"
		else
			buffer="\e[0m                 from \e[1m$(diag_normalize_location "${src}" "${line}")\n${buffer}"
		fi
	done
	echo -e "\e[1m${buffer}\e[0m"
}
