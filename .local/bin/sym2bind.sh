#!/usr/bin/env bash
#
# Copyright (c) 2021 Sergei Eremenko (https://github.com/SmartFinn)
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
# REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
# AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
# INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
# LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.

set -euo pipefail

PROGNAME="$(basename "${BASH_SOURCE[0]}")"
VERSION="0.1.0"
declare -i MAXDEPTH=1
declare -i FORCE_YES=0

usage() {
	cat <<- EOF
	This script finds symbolic links to directories and replace them with bind mount.

	USAGE
	  $ $PROGNAME [-d NUM] [-f] [-v] [DIR ..]

	OPTIONS
	  -d NUM    limit the depth of recursion (default: 1)
	  -f        do not ask when adding directory
	  -v        print version and exit
	  -h        show this help

	EXAMPLES
	  $ $PROGNAME     # find and suggest bind mount for symlinks in the current dir
	  $ $PROGNAME ~/  # find for symlinks in the HOME directory
	  $ $PROGNAME -d 2 ~/  # find symlinks in the HOME dir and subdirectories
	EOF

	exit "${1:-0}"
}

_yes_no() {
	local msg="$1"

	[ "$FORCE_YES" -eq 1 ] && return 0

	read -r -n 1 -e -p "$msg [Y/n]: " yes_no </dev/tty  # don't read from stdin

	case "$yes_no" in
		[Yy]|'') return 0 ;;
		[Nn]|*)  return 1 ;;
	esac
}

_no_yes() {
	local msg="$1"

	read -r -n 1 -e -p "$msg [y/N]: " yes_no </dev/tty  # don't read from stdin

	case "$yes_no" in
		[Yy])    return 0 ;;
		[Nn]|*)  return 1 ;;
	esac
}

hr() {
	printf '\n%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

while getopts ":hd:fv" opt; do
	case "$opt" in
	h)
		usage 0
		;;
	d)
		if ! [[ $OPTARG =~ [0-9]+ ]]; then
			echo "Error: option -$opt requires a number however '$OPTARG' was passed."
			usage 2
		fi
		MAXDEPTH="$OPTARG"
		;;
	f)
		FORCE_YES=1
		;;
	v)
		echo "$PROGNAME v$VERSION"
		exit 0
		;;
	:)
		echo "Error: option -$OPTARG requires an argument" >&2
		usage 2
		;;
	\?)
		echo "Invalid option: -$OPTARG" >&2
		usage 2
		;;
	esac
done

shift $((OPTIND-1))

declare -a DIRS=()
declare -A MOUNTPOINTS=()

for dir in "$@"; do
	if [ ! -d "$dir" ]; then
		echo "Error: '$dir' is not a directory."
		usage 2
	fi
	DIRS+=( "$(readlink -f "$dir")" )
done

if [ "${#DIRS[@]}" -eq 0 ]; then
	DIRS+=( "$(readlink -f "$(pwd)")" )
fi

while read -d$'\n' -r symlink; do
	mpoint="$(readlink -f "$symlink")"
	[ -d "$mpoint" ] || continue
	_yes_no "Add '$symlink' -> '$mpoint' to mount list?" || continue

	MOUNTPOINTS+=(["$mpoint"]="$symlink")
done < <(find "${DIRS[@]}" -maxdepth "$MAXDEPTH" -type l -print)

[ "${#MOUNTPOINTS[@]}" -gt 0 ] || exit 0

hr

echo
echo "The following lines will be added to /etc/fstab:"
echo

for mp in "${!MOUNTPOINTS[@]}"; do
	echo "  $mp ${MOUNTPOINTS["$mp"]} none bind 0 0"
done

echo
echo "The following symlinks will be replaced with directories:"
echo

for mp in "${!MOUNTPOINTS[@]}"; do
	echo " - ${MOUNTPOINTS["$mp"]}"
done

hr

_no_yes "Do you confirm actions above?" || exit 0

for dir in "${!MOUNTPOINTS[@]}"; do
	echo "$dir ${MOUNTPOINTS["$dir"]} none bind 0 0"
done | sudo tee -a /etc/fstab >/dev/null

for dir in "${!MOUNTPOINTS[@]}"; do
	mpoint="${MOUNTPOINTS["$dir"]}"
	[ -L "$mpoint" ] || continue

	rm -f "$mpoint"
	mkdir -p "$mpoint"
	sudo mount "$mpoint"
done
