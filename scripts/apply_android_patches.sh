#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC_DIR="$ROOT_DIR/upstream/blender"
PATCH_DIR="$ROOT_DIR/patches"

test -d "$SRC_DIR/.git"

PATCHES=(
  "$PATCH_DIR/0001-cmake-add-android-platform-selection.patch"
  "$PATCH_DIR/0002-ghost-add-android-backend-selection.patch"
  "$PATCH_DIR/0003-ghost-add-android-system-window-skeleton.patch"
  "$PATCH_DIR/0004-vulkan-add-android-surface-foundation.patch"
)

for patch in "${PATCHES[@]}"; do
  test -f "$patch"
  git -C "$SRC_DIR" apply --check "$patch"
  git -C "$SRC_DIR" apply "$patch"
  echo "Applied: $(basename "$patch")"
done

echo "Applied all Android source patches to pinned Blender source."
