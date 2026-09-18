# Android build bootstrap

This directory contains the Android-specific build layer. It does not contain a substitute Blender implementation.

The pinned upstream source revision is recorded in config/blender-source.env.

## Target

- ABI: arm64-v8a
- Minimum Android API: 26
- NDK: 29.0.14206865 (initial, subject to validation against the pinned Blender source)
- CMake: >= 3.21

Blender's upstream CMake currently enables desktop windowing backends such as X11 and Wayland on Unix. Android must receive its own GHOST/window/surface implementation rather than pretending to be X11 or Wayland.

No APK is considered valid until the native Blender engine itself is linked into the Android application.
