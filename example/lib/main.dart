import 'package:flutter/material.dart';
import 'dart:async';
import 'package:screen_security_kit/screen_security_kit.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _status = 'Waiting for action...';
  StreamSubscription? _screenshotSub;

  @override
  void initState() {
    super.initState();
    _initializeScreenSecurity();
  }

  Future<void> _initializeScreenSecurity() async {
    try {
      await ScreenSecurityKit.initialize();

      // Listen for screenshot events
      _screenshotSub = ScreenSecurityKit.onScreenshotTaken.listen((_) {
        setState(() {
          _status = 'Screenshot taken!';
        });
        _showSnackbar('⚠️ Screenshot detected!');
      });
    } catch (e) {
      debugPrint('Initialization error: $e');
    }
  }

  void _showSnackbar(String message) {
    final context = this.context;
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  void dispose() {
    _screenshotSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen Security Kit')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_status, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                await ScreenSecurityKit.disableScreenCapture();
                setState(() => _status = 'Screen capture disabled');
              },
              child: const Text('Disable Screen Capture'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                await ScreenSecurityKit.enableScreenCapture();
                setState(() => _status = 'Screen capture enabled');
              },
              child: const Text('Enable Screen Capture'),
            ),
          ],
        ),
      ),
    );
  }
}
