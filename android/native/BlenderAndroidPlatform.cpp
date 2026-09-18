#include "BlenderAndroidPlatform.h"

namespace blender::android {

void Platform::set_window(ANativeWindow *window)
{
  if (window_ == window) {
    return;
  }
  if (window) {
    ANativeWindow_acquire(window);
  }
  if (window_) {
    ANativeWindow_release(window_);
  }
  window_ = window;
}

void Platform::clear_window()
{
  set_window(nullptr);
}

ANativeWindow *Platform::window() const
{
  return window_;
}

}  // namespace blender::android
