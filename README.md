# Blender for Android

This repository is the Android-port workspace for building a real native Blender application for ARM64 Android. It is not a web app, remote desktop client, streaming client, or UI imitation.

## Current status

Phase 3 bootstrap is in progress. The upstream Blender source is pinned to commit `73d7b5f6362f5fb1b16526854b920ab719d4c65a` and is fetched reproducibly during development/CI. The Android-specific build layer is being developed on the `android-port` branch.

The current CI workflow is a **source/toolchain probe only**. It does not claim to compile Blender or produce an APK yet.

## Build target

- Android ABI: arm64-v8a
- Initial minimum API: 26
- Initial NDK baseline: 29.0.14206865
- CMake: >= 3.21
- Android application layer: Kotlin/Java + JNI/NDK
- Graphics target: Android Vulkan integration where the Blender GPU backend and device capabilities permit it

## Upstream source

Official Blender source: https://github.com/blender/blender

The exact source revision is recorded in `config/blender-source.env`.

## Development

The Android port must preserve desktop functionality. Android-specific platform behavior will be isolated behind platform-specific code, with GHOST/windowing, graphics-surface, input, lifecycle and filesystem integration added incrementally.

## License

Blender source remains under its applicable Blender licensing terms. This project will retain required third-party license and attribution notices and will not copy proprietary application code.
