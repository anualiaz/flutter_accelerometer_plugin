# Flutter Accelerometer Plugin

A lightweight Flutter plugin for accessing accelerometer data on Android and iOS devices.

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_accelerometer_plugin:
    git:
      url: https://github.com/anualiaz/flutter_accelerometer_plugin.git
```

Run:

```bash
flutter pub get
```

## Features

- Retrieve real-time accelerometer data (X, Y, Z axes).
- Supports Android and iOS platforms.
- Stream-based API for easy integration.

## Permissions

- **Android**: Add `<uses-permission android:name="android.permission.ACTIVITY_RECOGNITION" />` to `AndroidManifest.xml`.
- **iOS**: Include `NSMotionUsageDescription` in `Info.plist`.

## Usage

Check the `example/` directory for a sample implementation.

## Issues

Report bugs or suggest features on the [GitHub Issues page](https://github.com/anualiaz/flutter_accelerometer_plugin/issues).

## Author: Anu Alias 

