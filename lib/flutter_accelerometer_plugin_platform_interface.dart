import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_accelerometer_plugin_method_channel.dart';

abstract class FlutterAccelerometerPluginPlatform extends PlatformInterface {
  /// Constructs a FlutterAccelerometerPluginPlatform.
  FlutterAccelerometerPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterAccelerometerPluginPlatform _instance = MethodChannelFlutterAccelerometerPlugin();

  /// The default instance of [FlutterAccelerometerPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterAccelerometerPlugin].
  static FlutterAccelerometerPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterAccelerometerPluginPlatform] when
  /// they register themselves.
  static set instance(FlutterAccelerometerPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
