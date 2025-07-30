import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:screen_security_kit/screen_security_kit_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelScreenSecurityKit platform = MethodChannelScreenSecurityKit();
  const MethodChannel channel = MethodChannel('screen_security_kit');

  final List<MethodCall> log = <MethodCall>[];

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      log.add(methodCall);
      return null;
    });
    log.clear();
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
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
