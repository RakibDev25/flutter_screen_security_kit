# flutter_screen_security_kit

A Flutter plugin to improve screen security by managing screenshot behavior and notifying users when screenshots are taken.

---

## 🚀 Features

- ✅ **Android**
  - Enable/Disable screenshot capturing dynamically.
  - Automatically blurs app preview when switching apps.

- ✅ **iOS**
  - iOS does **not support disabling screenshots**.
  - However, this plugin **notifies the Flutter app** when the user takes a screenshot.

---

## 📷 Screenshots (Android, iOS)

### Android

![Screenshots](https://github.com/RakibDev25/flutter_screen_security_kit/raw/main/assets/images.png)

---

## 📦 Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  screen_security_kit: ^1.0.1
```
```dart
import 'package:screen_security_kit/screen_security_kit.dart';

// Initialize (recommended in main or initState)
await ScreenSecurityKit.initialize();

// Listen for screenshot events
ScreenSecurityKit.onScreenshotTaken.listen((_) {
  print('Screenshot detected!');
});

// Disable screen capture
await ScreenSecurityKit.disableScreenCapture();

// Enable screen capture
await ScreenSecurityKit.enableScreenCapture();
```

## 🚀 Example

Check out the [example app here](https://github.com/RakibDev25/flutter_screen_security_kit/blob/main/example/lib/main.dart).


## 🤝 Contribute
Contributions are welcome!

If you find a bug or have a feature request, feel free to open an issue or submit a pull request. Please follow standard Flutter/Dart formatting and write clear commit messages.

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)


