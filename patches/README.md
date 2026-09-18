# Android source patches

Android-specific changes are kept as small patches against the pinned Blender source instead of copying the upstream tree into this repository.

The first patch adds an Android platform selection point to Blender's top-level CMake logic. It does not implement GHOST, Vulkan, JNI, input, or the Android application yet.

The patch is intentionally isolated so desktop builds continue using their existing platform files.
