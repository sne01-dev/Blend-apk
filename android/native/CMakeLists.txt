add_library(blender_android_platform STATIC
  BlenderAndroidPlatform.cpp
)

target_include_directories(blender_android_platform
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)

target_link_libraries(blender_android_platform
  PUBLIC
    android
)
