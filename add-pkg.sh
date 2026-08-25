#!/bin/bash

set -euo pipefail

if [[ $# -ne 1 ]] || [[ -z "$1" ]]; then
  echo "Usage: $0 <package-name>"
  exit 1
fi

git subtree add --prefix=$1 ssh://aur@aur.archlinux.org/$1.git master
