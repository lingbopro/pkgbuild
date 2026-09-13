#!/bin/bash

set -euo pipefail

if [[ $# -ne 2 ]] || [[ -z "$1" ]] || [[ -z "$2" ]]; then
  echo "Usage: $0 <add|pull|push> <package-name>"
  exit 1
fi

root="$(dirname "$0")"
pushd "$root" >/dev/null

git subtree $1 --prefix=$2 ssh://aur@aur.archlinux.org/$2.git master

popd >/dev/null
