#!/usr/bin/env bash

os="`cat /etc/os-release | grep -E '^ID=' | awk -F '=' '{ print $2 }'`"

if [[ -z $os ]]; then
	echo 'OS not set' 1>&2
	exit 1
fi


function install () {
	case $os in
		arch)
			pacman -Q "$@" > /dev/null 2> /dev/null
			installed=$(echo $?)
			if [[ ! $installed == 0 ]]; then
				echo "'$@' where not installed, to be install"
				sudo pacman -Sy --noconfirm "$@" #> /dev/null
				echo "'$@' where installed"
			fi
		;;
		ubuntu)
			sudo apt install "$@"
		;;
		*)
			echo 'Not a supported os' 1>&2
			return 1
	esac
}

function uninstall () {
	case $os in
		arch)
			sudo pacman -Rs --noconfirm "$@"
		;;
		ubuntu)
			sudo apt purge "$@"
		;;
		*)
			echo 'Not a supported os' 1>&2
			return 1
	esac
}

function upgrade() {
	case $os in
		arch)
			sudo pacman -Syy
		;;
		ubuntu)
			sudo apt update
		;;
		*)
			echo 'Not a supported os' 1>&2
			return 1
	esac
}
