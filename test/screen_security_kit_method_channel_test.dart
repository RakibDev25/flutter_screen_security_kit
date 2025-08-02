import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:screen_security_kit/screen_security_kit_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Use the same channel name as in your MethodChannelScreenSecurityKit implementation
  const MethodChannel channel = MethodChannel('com.example.screensecuritykit_rakibul25/methods');
  final List<MethodCall> log = <MethodCall>[];

  late MethodChannelScreenSecurityKit platform;

  setUp(() {
    platform = MethodChannelScreenSecurityKit();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      log.add(methodCall);
      return null;
    });
    log.clear();
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('disableScreenCapture sends correct method call', () async {
    await platform.disableScreenCapture();
    expect(log, <Matcher>[
      isA<MethodCall>().having((m) => m.method, 'method', 'disableScreenCapture'),
    ]);
  });

  test('enableScreenCapture sends correct method call', () async {
    await platform.enableScreenCapture();
    expect(log, <Matcher>[
      isA<MethodCall>().having((m) => m.method, 'method', 'enableScreenCapture'),
    ]);
  });
}