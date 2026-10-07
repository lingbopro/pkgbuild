#!/bin/bash

set -euo pipefail

GREY="\x1b[38;5;240m"
RESET="\x1b[0m"

if [[ $# -ne 2 ]] || [[ -z "$1" ]] || [[ -z "$2" ]]; then
  echo "Usage: $0 <add|pull|push> <package-name>"
  exit 1
fi

root="$(dirname "$0")"
pushd "$root" >/dev/null

pkgname="$(echo "$2" | sed 's/\.//; s/\///')"

cmd="git subtree $1 --prefix=$pkgname ssh://aur@aur.archlinux.org/$pkgname.git master"
echo -e "${GREY}$ $cmd${RESET}"

eval "$cmd"

popd >/dev/null
