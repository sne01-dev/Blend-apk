# Dependency audit — pinned Blender 73d7b5f6362f5fb1b16526854b920ab719d4c65a

## What the upstream build system tells us

Blender's dependency builder is a CMake project under `build_files/build_environment`. The pinned source's `CMakeLists.txt` includes dependency recipes for zlib, OpenAL, PNG, JPEG, OpenEXR/Imath, Brotli, FreeType, Epoxy, Alembic, OpenSubdiv, SDL, TIFF, TBB, Python, LLVM, OSL, NumPy, OpenImageIO, USD, MaterialX, OpenVDB, HarfBuzz, OpenXR, Embree and other components.

The authoritative dependency versions for this source revision are in:
`upstream/blender/build_files/build_environment/cmake/versions.cmake`.

## Android implications

The official precompiled `lib/` libraries are platform-specific and are not Android libraries. Blender's documentation says those precompiled libraries are provided for supported desktop platforms, while `make deps` builds dependencies from source and is primarily intended for platform maintainers.

Therefore an Android build cannot simply reuse `lib/linux_x64` or `lib/linux_arm64`: those are Linux/glibc builds, not Android/Bionic builds.

## Initial dependency policy

Dependencies are grouped by what the first Android milestone actually needs.

### Required early

- zlib
- PNG/JPEG
- C/C++ runtime and pthread-compatible platform facilities
- Blender's own internal libraries
- Vulkan headers/loader integration
- Python runtime, if the normal Blender UI/startup path remains enabled
- FreeType/harfbuzz/font stack required by the UI

### Required for broad feature parity

- OpenImageIO/OpenEXR/Imath
- OpenColorIO
- OpenSubdiv
- OpenVDB
- TBB
- OSL
- OpenAL/audio stack
- FFmpeg
- USD/MaterialX and other import/export stacks

### Potentially disabled for the first boot milestone

GPU-compute stacks that are desktop-vendor-specific, such as CUDA/HIP/oneAPI paths, may be disabled for Android unless a particular Android-compatible implementation is proven necessary.

This is not removal of Blender functionality from the source; it is build-option scoping for the initial Android target.

## Critical Python finding

The pinned source's Unix Python finder expects Blender's supported Python version to be **3.13** and searches for a native Unix Python library. An Android build therefore needs an Android-built/embedded Python runtime rather than linking against the host Linux Python shared library.

## Critical graphics finding

The Unix platform configuration expects desktop library directories and currently discovers Vulkan through the desktop dependency setup. Android will require an Android-specific dependency/toolchain path and Android Vulkan loader/surface integration.

## Next engineering milestone

Do not build all dependencies blindly.

First create a minimal Android dependency profile and native configure probe. The probe should deliberately disable desktop-only subsystems and report the first missing/unsupported dependency. Each dependency should then be cross-compiled or patched individually.

## Sources

- Blender dependency version manifest: `build_files/build_environment/cmake/versions.cmake`
- Dependency builder: `build_files/build_environment/CMakeLists.txt`
- Unix platform dependency configuration: `build_files/cmake/platform/platform_unix.cmake`
- GHOST build selection: `intern/ghost/CMakeLists.txt`
