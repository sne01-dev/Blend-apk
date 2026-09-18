# Android native configure probe

This probe is deliberately **not** an Android Blender build and does not produce an APK.

It answers a narrower engineering question first: whether the pinned Blender source can enter CMake configuration under the Android NDK toolchain after desktop-only windowing, GPU backends, Python, codecs, and broad optional features are disabled.

The probe uses:

- Blender commit: `73d7b5f6362f5fb1b16526854b920ab719d4c65a`
- ABI: `arm64-v8a`
- Android API baseline: `26`
- Android NDK: value from `config/blender-source.env`
- CMake generator: Ninja
- out-of-source build

A failure is useful: it identifies the first source/build-system/dependency assumption that is incompatible with Android. We then fix that concrete blocker rather than adding speculative Android code.

The probe intentionally disables GHOST graphics and Python. Those are temporary isolation settings only; the final application will require an Android GHOST/window/surface implementation, native input/lifecycle integration, Python runtime integration, and graphics backend integration.
