# Android platform configuration for the Blender Android port.

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

# Bootstrap defaults. Android-specific probes may explicitly enable these
# features once their native dependencies are available.
set(WITH_PYTHON OFF CACHE BOOL "" FORCE)
set(WITH_OPENGL_BACKEND OFF CACHE BOOL "" FORCE)
set(WITH_VULKAN_BACKEND OFF CACHE BOOL "")
