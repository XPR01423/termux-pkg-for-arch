#!/usr/bin/bash
set -eu

if [[ "$(id -u)" == "0" ]]; then
	echo "Error: Cannot run 'pkg' command as root"
	exit 1
fi

show_help() {
	echo 'Usage: pkg command [arguments]'
	echo
	echo "A tool for managing pacman packages on Arch Linux."
	echo
	echo 'Commands:'
	echo
	echo "  autoclean            - Remove all unused packages (pacman -Rns)"
	echo "  clean                - Clear pacman cache (pacman -Sc)"
	echo "  files <packages>     - Show all files installed by packages (pacman -Ql)"
	echo "  install <packages>   - Install specified packages (pacman -S)"
	echo "  list-all             - List all packages available in repositories (pacman -Ss)"
	echo "  list-installed       - List installed packages (pacman -Q)"
	echo "  reinstall <packages> - Reinstall specified installed packages (pacman -S --overwrite)"
	echo "  search <query>       - Search package by query (pacman -Ss)"
	echo "  show <packages>      - Show package info (pacman -Qi)"
	echo "  uninstall <packages> - Remove specified packages (pacman -R)"
	echo "  upgrade              - Upgrade all packages (pacman -Syu)"
	echo "  update               - Sync package databases (pacman -Sy)"
	echo
	exit 1
}

if [[ $# = 0 || $(echo "$1" | grep "^h") ]]; then
	show_help
fi

CMD="$1"
shift 1
ERROR=false

case "$CMD" in
	f*) pacman -Ql "$@";;
	sh*|inf*) pacman -Qi "$@";;
	add|i*) sudo pacman -S --noconfirm "$@";;
	autoc*) sudo pacman -Rns $(pacman -Qtdq) || echo "No unused packages to remove.";;
	cl*) sudo pacman -Sc --noconfirm;;
	list-a*) pacman -Ss "$@";;
	list-i*) pacman -Q "$@";;
	rei*) sudo pacman -S --noconfirm --overwrite "*" "$@";;
	se*) pacman -Ss "$@";;
	un*|rem*|rm|del*) sudo pacman -R --noconfirm "$@";;
	upd*) sudo pacman -Sy;;
	up|upg*) sudo pacman -Syu --noconfirm;;
	*) ERROR=true;;
esac

if $ERROR; then
	echo "Unknown command: '$CMD' (run 'pkg help' for usage information)"
	exit 1
fi
