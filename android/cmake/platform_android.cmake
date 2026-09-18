# Android platform configuration for the Blender Android port.
#
# This file is intentionally minimal. Dependency discovery and Android-specific
# GHOST integration will be added only after the platform-selection boundary
# is proven by CMake configuration.

message(STATUS "Configuring Blender for Android")

set(WITH_LIBS_PRECOMPILED OFF CACHE BOOL "" FORCE)

# Android uses the NDK/Bionic runtime and must not enter Blender's desktop
# Unix platform dependency discovery.
set(WITH_SYSTEM_FREETYPE ON CACHE BOOL "" FORCE)
set(WITH_GHOST_X11 OFF CACHE BOOL "" FORCE)
set(WITH_GHOST_WAYLAND OFF CACHE BOOL "" FORCE)
set(WITH_GHOST_SDL OFF CACHE BOOL "" FORCE)
set(WITH_GHOST_DBUS OFF CACHE BOOL "" FORCE)
set(WITH_XR_OPENXR OFF CACHE BOOL "" FORCE)
set(WITH_OPENAL OFF CACHE BOOL "" FORCE)
set(WITH_CODEC_FFMPEG OFF CACHE BOOL "" FORCE)
set(WITH_CODEC_SNDFILE OFF CACHE BOOL "" FORCE)
set(WITH_INPUT_NDOF OFF CACHE BOOL "" FORCE)

# These are temporary bootstrap restrictions, not final feature decisions.
# The Android application will later restore Python, Vulkan and the supported
# Blender feature set after Android-native dependencies are available.
set(WITH_PYTHON OFF CACHE BOOL "" FORCE)
set(WITH_OPENGL_BACKEND OFF CACHE BOOL "" FORCE)
set(WITH_VULKAN_BACKEND OFF CACHE BOOL "" FORCE)
