import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_accelerometer_plugin_platform_interface.dart';

/// An implementation of [FlutterAccelerometerPluginPlatform] that uses method channels.
class MethodChannelFlutterAccelerometerPlugin extends FlutterAccelerometerPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_accelerometer_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
