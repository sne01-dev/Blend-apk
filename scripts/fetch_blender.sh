#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT_DIR/config/blender-source.env"

SRC_DIR="$ROOT_DIR/upstream/blender"

mkdir -p "$ROOT_DIR/upstream"

if [[ ! -d "$SRC_DIR/.git" ]]; then
  git clone --filter=blob:none --no-checkout "$BLENDER_REPOSITORY" "$SRC_DIR"
fi

git -C "$SRC_DIR" fetch --no-tags origin "$BLENDER_COMMIT"
git -C "$SRC_DIR" checkout --detach "$BLENDER_COMMIT"

echo "Blender source pinned to:"
git -C "$SRC_DIR" rev-parse HEAD
