# Blender Android Port — Phase 2 Analysis

## Current repository
- Project repository: `sne01-dev/Blend-apk`
- Working branch: `android-port`
- The project repository was initially empty.
- This project does not yet contain a copied Blender source tree.

## Upstream Blender source baseline
The official Blender source is a large C/C++/Python project using CMake and the GNU make wrapper. The Android port must therefore add an Android platform layer rather than rewrite Blender in Kotlin.

The current upstream source tree includes major areas such as:
- `source/` — Blender C/C++ implementation
- `intern/` — internal libraries
- `extern/` — external components
- `build_files/` — build/dependency machinery
- `lib/` — prebuilt/managed libraries where applicable
- `release/` — runtime data, scripts and packaging resources
- `.github/` — upstream CI configuration

## Build-system findings
Blender's documented build system is CMake, normally driven through its `make` wrapper. Blender requires an out-of-source build. The normal desktop build flow is not an Android build flow.

The Android project must therefore introduce:
1. Android NDK/CMake toolchain configuration.
2. Android-specific platform detection.
3. An Android application/native entry point.
4. A graphics-surface bridge.
5. Input/lifecycle/filesystem bridges.
6. Gradle packaging around native libraries and Blender runtime data.

## Critical platform boundary
Blender's desktop application startup and event handling are built around its GHOST window/input abstraction and desktop platform implementations. Android cannot safely be treated as Linux/X11/Wayland.

The first Android milestone should therefore avoid broad core rewrites:
- preserve desktop GHOST implementations;
- add an Android-specific platform implementation where required;
- keep Android code behind platform-specific compilation;
- make the smallest changes necessary to obtain a native Android process and rendering surface.

## Graphics
Blender currently contains Vulkan GPU infrastructure, but the existence of desktop Vulkan support does not by itself make the Android application layer work. Android surface/swapchain lifecycle and device capabilities must be handled explicitly.

The first graphics milestone is Vulkan surface creation and a stable render loop. Feature-dependent Blender GPU functionality will be enabled incrementally after that.

## Input
Android touch/stylus events need translation into Blender's event model. Hardware keyboard/mouse input should remain supported when Android supplies those events.

Gesture semantics should be implemented above the low-level event bridge where possible, rather than scattering Android gesture code through Blender editors.

## Filesystem
Desktop absolute paths must not be used as Android user-document locations. The Android layer should expose app-private storage plus Storage Access Framework document URIs. A URI/file-descriptor bridge will be needed for user-selected .blend files and assets.

## Dependencies
Dependency versions must be derived from the selected Blender source revision and its build-environment definitions. No arbitrary Android dependency versions are being introduced at this stage.

## Phase order
1. Freeze/select an exact Blender source revision.
2. Establish a reproducible source/dependency bootstrap.
3. Add NDK/CMake Android toolchain.
4. Compile the smallest native Blender target possible.
5. Add Android Activity + JNI/native entry.
6. Add surface/rendering integration.
7. Add lifecycle.
8. Add input/stylus.
9. Add filesystem/document integration.
10. Package debug APK.
11. Test with adb/emulator where available.
12. Fix measured failures.
13. Add CI build.
14. Optimize.

## Important limitation at this checkpoint
GitHub connector access can modify repository files and commits, but it does not provide an Android emulator/device or an arbitrary native build runner in this conversation. Therefore an APK must not be claimed until an actual Android-capable build runner executes the build and produces the APK.

## Licensing
The Android integration will contain only original project code plus compatible open-source components. Blender's existing license and third-party notices must remain intact when the source is incorporated.
