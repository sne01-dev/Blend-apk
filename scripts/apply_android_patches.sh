#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC_DIR="$ROOT_DIR/upstream/blender"
PATCH_DIR="$ROOT_DIR/patches"

test -d "$SRC_DIR/.git"
test -f "$PATCH_DIR/0001-cmake-add-android-platform-selection.patch"

git -C "$SRC_DIR" apply --check "$PATCH_DIR/0001-cmake-add-android-platform-selection.patch"
git -C "$SRC_DIR" apply "$PATCH_DIR/0001-cmake-add-android-platform-selection.patch"

echo "Applied Android platform-selection patch to pinned Blender source."
