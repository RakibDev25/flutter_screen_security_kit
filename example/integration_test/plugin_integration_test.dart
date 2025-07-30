import 'package:flutter_test/flutter_test.dart';
import 'package:screen_security_kit/screen_security_kit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ScreenSecurityKit integration test', () {
    test('Should call disableScreenCapture without error', () async {
      // Since there's no actual platform channel in the test environment,
      // we're only checking for callability without throwing
      try {
        await ScreenSecurityKit.disableScreenCapture();
        expect(true, isTrue); // dummy assertion
      } catch (e) {
        fail('disableScreenCapture threw an exception: $e');
      }
    });

    test('Should call enableScreenCapture without error', () async {
      try {
        await ScreenSecurityKit.enableScreenCapture();
        expect(true, isTrue); // dummy assertion
      } catch (e) {
        fail('enableScreenCapture threw an exception: $e');
      }
    });
  });
}
