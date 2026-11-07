#!/bin/bash

set -euo pipefail

cat << EOF > .git/hooks/pre-commit

PKGBUILDS=\$(git diff --cached --name-only --diff-filter=ACM | grep 'PKGBUILD$' || true)

if [ -z "\$PKGBUILDS" ]; then
  exit 0
fi

if ! command -v makepkg &> /dev/null; then
  echo '==> WARNING: makepkg not found, skipping .SRCINFO check'
fi

for PKGBUILD in \$PKGBUILDS; do
  pkgname=\$(echo "\$PKGBUILD" | sed 's/\/PKGBUILD$//')
  ./check-srcinfo.sh "\$pkgname"
done

EOF

chmod +x .git/hooks/pre-commit
