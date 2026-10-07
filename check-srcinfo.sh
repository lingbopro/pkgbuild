#!/bin/bash

set -euo pipefail

RED="\x1b[31m"
BLUE="\x1b[34m"
RESET="\x1b[0m"

if [[ $# > 1 ]]; then
  echo "Usage: $0 [package-name]"
  exit 1
fi

root="$(dirname "$0")"

check_single() {
  [[ -z "$1" ]] && return 1
  echo -ne " ${BLUE}->${RESET} Checking .SRCINFO status of ${BLUE}$1${RESET} ... "
  dir="$root/$1"
  pushd "$dir" >/dev/null
  new_srcinfo="$(makepkg --printsrcinfo)"
  popd >/dev/null
  if [[ "$new_srcinfo" == "$(cat "$dir/.SRCINFO")" ]]; then
    echo 'Passed'
  else
    echo -e "${RED}FAILED${RESET}"
    echo "$new_srcinfo" | diff --color=always "$dir/.SRCINFO" -
    return 1
  fi
}

if [[ $# == 1 ]]; then
  check_single "$1"
else
  for pkg in $(cat "$root/pkglist.txt"); do
    check_single "$pkg"
  done
fi
