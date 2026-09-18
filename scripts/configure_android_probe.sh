#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT_DIR/config/blender-source.env"

SRC_DIR="$ROOT_DIR/upstream/blender"
BUILD_DIR="$ROOT_DIR/build/android-configure-probe"
NDK_DIR="${ANDROID_NDK_HOME:-${ANDROID_NDK_ROOT:-}}"

if [[ -z "$NDK_DIR" ]]; then
  echo "ERROR: ANDROID_NDK_HOME/ANDROID_NDK_ROOT is not set." >&2
  exit 2
fi

TOOLCHAIN="$NDK_DIR/build/cmake/android.toolchain.cmake"
if [[ ! -f "$TOOLCHAIN" ]]; then
  echo "ERROR: Android NDK CMake toolchain not found: $TOOLCHAIN" >&2
  exit 2
fi

test -d "$SRC_DIR/.git"
test "$(git -C "$SRC_DIR" rev-parse HEAD)" = "$BLENDER_COMMIT"

"$ROOT_DIR/scripts/apply_android_patches.sh"

rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

cmake -S "$SRC_DIR" -B "$BUILD_DIR" -G Ninja \
  -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN" \
  -DANDROID_ABI="$ANDROID_ABI" \
  -DANDROID_PLATFORM="android-$ANDROID_PLATFORM" \
  -DCMAKE_BUILD_TYPE=Debug \
  -DWITH_LIBS_PRECOMPILED=OFF \
  -DWITH_HEADLESS=OFF \
  -DWITH_GHOST_X11=OFF \
  -DWITH_GHOST_WAYLAND=OFF \
  -DWITH_GHOST_SDL=OFF \
  -DWITH_OPENGL_BACKEND=OFF \
  -DWITH_VULKAN_BACKEND=ON \
  -DWITH_PYTHON=OFF \
  -DWITH_CODEC_FFMPEG=OFF \
  -DWITH_CODEC_SNDFILE=OFF \
  -DWITH_ALEMBIC=OFF \
  -DWITH_USD=OFF \
  -DWITH_MATERIALX=OFF \
  -DWITH_HYDRA=OFF \
  -DWITH_CYCLES=OFF \
  -DWITH_OPENVDB=OFF \
  -DWITH_OPENSUBDIV=OFF \
  -DWITH_OPENIMAGEIO=OFF \
  -DWITH_IMAGE_OPENJPEG=OFF \
  -DWITH_IMAGE_CINEON=OFF \
  -DWITH_IMAGE_WEBP=OFF \
  -DWITH_AUDASPACE=OFF \
  -DWITH_OPENAL=OFF \
  -DWITH_INPUT_NDOF=OFF \
  -DWITH_XR_OPENXR=OFF \
  -DWITH_GMP=OFF

echo "Android Vulkan CMake configure probe completed."
echo "Build directory: $BUILD_DIR"
