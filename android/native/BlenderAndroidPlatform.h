#pragma once

#include <android/native_window.h>

namespace blender::android {

class Platform {
 public:
  void set_window(ANativeWindow *window);
  void clear_window();
  ANativeWindow *window() const;

 private:
  ANativeWindow *window_ = nullptr;
};

}  // namespace blender::android
