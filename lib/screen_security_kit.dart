library screen_security_kit;

import 'dart:async';
import 'screen_security_kit_platform_interface.dart';

/// Provides an interface for controlling screen security features such as
/// disabling screen capture and detecting screenshots.
///
/// This class acts as a facade for platform-specific implementations.
/// Call [initialize] once at app startup to set up necessary listeners.
class ScreenSecurityKit {
  /// Prevents screen capture (screenshots and screen recording) on supported platforms.
  ///
  /// On Android, this sets the FLAG_SECURE window flag.
  static Future<void> disableScreenCapture() {
    return ScreenSecurityKitPlatform.instance.disableScreenCapture();
  }

  /// Re-enables screen capture (screenshots and screen recording) on supported platforms.
  ///
  /// Removes any restrictions set by [disableScreenCapture].
  static Future<void> enableScreenCapture() {
    return ScreenSecurityKitPlatform.instance.enableScreenCapture();
  }

  /// Initializes the plugin and sets up platform-specific event listeners.
  ///
  /// Call this once during app startup before using other features.
  static Future<void> initialize() {
    return ScreenSecurityKitPlatform.instance.initialize();
  }

  /// Emits an event whenever a screenshot is detected on iOS devices.
  ///
  /// This stream only works on iOS. No events are emitted on other platforms.
  static Stream<void> get onScreenshotTaken =>
      ScreenSecurityKitPlatform.instance.onScreenshotTaken;
}
