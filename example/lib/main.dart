import 'package:flutter/material.dart';
import 'dart:async';
import 'package:screen_security_kit/screen_security_kit.dart';

void main() {
  runApp(const MyAppRoot());
}

class MyAppRoot extends StatelessWidget {
  const MyAppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Screen Security Kit',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyApp(),
    );
  }
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
      _screenshotSub = ScreenSecurityKit.onScreenshotTaken.listen((_) {
        setState(() {
          _status = 'Screenshot taken!';
        });
        _showAlertDialog('⚠️ Screenshot detected!');
      });
    } catch (e) {
      debugPrint('Initialization error: $e');
    }
  }

  void _showAlertDialog(String message) {
    final context = this.context;
    if (!context.mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _screenshotSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen Security Kit'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Icon(Icons.security, size: 48, color: Colors.deepPurple),
                      const SizedBox(height: 16),
                      Text(
                        _status,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: _status == 'Screenshot taken!'
                              ? Colors.red
                              : Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Column(
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.block),
                        label: const Text('Disable Screen Capture'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(48),
                        ),
                        onPressed: () async {
                          await ScreenSecurityKit.disableScreenCapture();
                          setState(() => _status = 'Screen capture disabled');
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.lock_open),
                        label: const Text('Enable Screen Capture'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(48),
                        ),
                        onPressed: () async {
                          await ScreenSecurityKit.enableScreenCapture();
                          setState(() => _status = 'Screen capture enabled');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}