import 'dart:async';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'screen_security_kit_method_channel.dart';

/// Abstract platform interface for the screen security plugin.
///
/// Platform-specific implementations should extend this class to provide
/// native functionality for screen capture control and screenshot detection.
abstract class ScreenSecurityKitPlatform extends PlatformInterface {
  /// Ensures this class can’t be directly implemented externally.
  ScreenSecurityKitPlatform() : super(token: _token);

  static final Object _token = Object();

  static ScreenSecurityKitPlatform _instance = MethodChannelScreenSecurityKit();

  /// The default instance of [ScreenSecurityKitPlatform] to use.
  ///
  /// Defaults to [MethodChannelScreenSecurityKit]. Platform-specific
  /// implementations should set this to their own class.
  static ScreenSecurityKitPlatform get instance => _instance;

  /// Sets the platform-specific implementation of [ScreenSecurityKitPlatform].
  ///
  /// Verifies the token to ensure only valid implementations are used.
  static set instance(ScreenSecurityKitPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Disables screen capture (screenshots and recordings) on supported platforms.
  ///
  /// Must be implemented by platform-specific subclasses.
  Future<void> disableScreenCapture() {
    throw UnimplementedError('disableScreenCapture() has not been implemented.');
  }

  /// Enables screen capture again on supported platforms.
  ///
  /// Must be implemented by platform-specific subclasses.
  Future<void> enableScreenCapture() {
    throw UnimplementedError('enableScreenCapture() has not been implemented.');
  }

  /// Initializes the plugin and sets up any required native event listeners.
  ///
  /// Must be implemented by platform-specific subclasses.
  Future<void> initialize() {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  /// Stream that emits an event whenever a screenshot is detected (iOS only).
  ///
  /// Must be implemented by platform-specific subclasses. Emits `void` events.
  Stream<void> get onScreenshotTaken {
    throw UnimplementedError('onScreenshotTaken getter has not been implemented.');
  }
}
