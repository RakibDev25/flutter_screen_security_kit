import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:screen_security_kit/screen_security_kit.dart';
import 'package:screen_security_kit/screen_security_kit_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockScreenSecurityKitPlatform
    with MockPlatformInterfaceMixin
    implements ScreenSecurityKitPlatform {
  bool disabled = false;
  bool enabled = false;
  bool initialized = false;
  final StreamController<void> _screenshotController = StreamController<void>.broadcast();

  @override
  Future<void> disableScreenCapture() async {
    disabled = true;
  }

  @override
  Future<void> enableScreenCapture() async {
    enabled = true;
  }

  @override
  Future<void> initialize() async {
    initialized = true;
  }

  @override
  Stream<void> get onScreenshotTaken => _screenshotController.stream;

  // Helper to emit screenshot event for test
  void emitScreenshotEvent() {
    _screenshotController.add(null);
  }

  void dispose() {
    _screenshotController.close();
  }
}

void main() {
  final mockPlatform = MockScreenSecurityKitPlatform();
  ScreenSecurityKitPlatform.instance = mockPlatform;

  tearDown(() {
    mockPlatform.dispose();
  });

  test('disableScreenCapture calls platform implementation', () async {
    await ScreenSecurityKit.disableScreenCapture();
    expect(mockPlatform.disabled, true);
  });

  test('enableScreenCapture calls platform implementation', () async {
    await ScreenSecurityKit.enableScreenCapture();
    expect(mockPlatform.enabled, true);
  });

  test('initialize calls platform implementation', () async {
    await ScreenSecurityKit.initialize();
    expect(mockPlatform.initialized, true);
  });

  test('onScreenshotTaken stream emits event', () async {
    final events = <void>[];
    final subscription = ScreenSecurityKit.onScreenshotTaken.listen(events.add);

    mockPlatform.emitScreenshotEvent();

    await Future.delayed(Duration.zero); // wait event loop
    expect(events.length, 1);

    await subscription.cancel();
  });
}
