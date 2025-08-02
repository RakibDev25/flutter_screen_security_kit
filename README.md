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

## 📷 Screenshots

### Android

<table>
  <tr>
    <td><b>Screenshot Enabled/Disabled</b></td>
    <td><b>App Switch Blur</b></td>
  </tr>
  <tr>
    <td><img src="https://github.com/RakibDev25/flutter_screen_security_kit/blob/main/assets/Screenshot_2025_08_01_19_56_09_33_64b749b07536bc4701338803e76bb217.jpg?raw=true" width="250" height="475"/></td>
    <td><img src="https://github.com/RakibDev25/flutter_screen_security_kit/blob/main/assets/Screenshot_2025_08_01_19_56_50_71_b783bf344239542886fee7b48fa4b892.jpg?raw=true" width="250" height="475"/></td>
  </tr>
</table>

### iOS

<table>
  <tr>
    <td><b>Normal UI</b></td>
    <td><b>Screenshot Taken Dialog</b></td>
  </tr>
  <tr>
    <td><img src="https://github.com/RakibDev25/flutter_screen_security_kit/blob/main/assets/IMG_0536.PNG?raw=true" width="250" height="475"/></td>
    <td><img src="https://github.com/RakibDev25/flutter_screen_security_kit/blob/main/assets/IMG_0537.PNG?raw=true" width="250" height="475"/></td>
  </tr>
</table>


---

## 📦 Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  screen_security_kit: ^1.0.0
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

Check out the [example app here](https://github.com/RakibDev25/flutter_screen_security_kit/blob/main/example/lib/main.dart) to see how to use this plugin.


## 🤝 Contribute
Contributions are welcome!

If you find a bug or have a feature request, feel free to open an issue or submit a pull request. Please follow standard Flutter/Dart formatting and write clear commit messages.

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)


