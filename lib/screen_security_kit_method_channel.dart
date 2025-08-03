import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'screen_security_kit_platform_interface.dart';

/// Platform-specific implementation of [ScreenSecurityKitPlatform] using MethodChannel.
///
/// Handles communication with native Android and iOS code to control screen capture
/// and listen for screenshot events.
class MethodChannelScreenSecurityKit extends ScreenSecurityKitPlatform {
  /// MethodChannel for invoking native methods related to screen security.
  ///
  /// Used to enable or disable screen capture on Android.
  @visibleForTesting
  final MethodChannel methodChannel =
      const MethodChannel('com.example.screensecuritykit_rakibul25/methods');

  /// EventChannel for receiving screenshot events from iOS.
  ///
  /// Emits events when the user takes a screenshot. Only supported on iOS.
  final EventChannel _eventChannel =
      const EventChannel('com.example.screensecuritykit_rakibul25/events');

  /// Internal stream for broadcasting screenshot events.
  Stream<void>? _onScreenshotTakenStream;

  /// Disables screen capture (screenshots and recordings) on supported platforms.
  ///
  /// Throws a [PlatformException] if the operation fails.
  @override
  Future<void> disableScreenCapture() async {
    try {
      await methodChannel.invokeMethod('disableScreenCapture');
    } on PlatformException catch (e) {
      throw 'Failed to disable screen capture: ${e.message}';
    }
  }

  /// Enables screen capture (screenshots and recordings) on supported platforms.
  ///
  /// Removes any restrictions set by [disableScreenCapture].
  /// Throws a [PlatformException] if the operation fails.
  @override
  Future<void> enableScreenCapture() async {
    try {
      await methodChannel.invokeMethod('enableScreenCapture');
    } on PlatformException catch (e) {
      throw 'Failed to enable screen capture: ${e.message}';
    }
  }

  /// Initializes the plugin and sets up any required native listeners.
  ///
  /// No special initialization is required for MethodChannel, but this method
  /// matches the platform interface for consistency.
  @override
  Future<void> initialize() async {
    return;
  }

  /// Stream that emits an event whenever a screenshot is detected on iOS.
  ///
  /// Emits `null` for each screenshot event. No events are emitted on other platforms.
  @override
  Stream<void> get onScreenshotTaken {
    if(!Platform.isIOS) {
      // If not on iOS, return an empty stream
      return const Stream<void>.empty();
    }
    _onScreenshotTakenStream ??=
        _eventChannel.receiveBroadcastStream().map((event) {
      if (event == 'screenshotTaken') {
        return null; // just emit an event (void)
      }
      return null;
    });
    return _onScreenshotTakenStream!;
  }
}
