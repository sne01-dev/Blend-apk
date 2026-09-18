# GHOST Android interface plan

The pinned Blender GHOST interfaces were inspected before implementation.

Android will use two platform classes:

- `GHOST_SystemAndroid : GHOST_System`
- `GHOST_WindowAndroid : GHOST_Window`

The system class owns Android event/lifecycle state and creates/disposes the Android window. The window class owns the `ANativeWindow` reference and the eventual Vulkan drawing context.

The first implementation milestone deliberately does **not** fake Vulkan or input events. Unsupported window operations return the same failure/no-op semantics used by existing GHOST backends until their Android implementation is added.

The next source patch will add these classes to Blender's GHOST CMake source list and wire system creation only after the exact static factory/backend-selection code is verified.
