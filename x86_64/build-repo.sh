#!/bin/bash
set -e

ARCH_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "$ARCH_DIR"

echo "==> Building Kiri repo index for x86_64..."

if [ ! -d "packages" ] || [ -z "$(ls -A packages/*.hpkg 2>/dev/null)" ]; then
    echo "Error: No .hpkg files found in $ARCH_DIR/packages/"
    exit 1
fi

# Create binary repo index at the architecture root
package_repo create repo.info repo packages/*.hpkg

echo "==> Repository index successfully generated at $ARCH_DIR/repo"
