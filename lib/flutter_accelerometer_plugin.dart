
import 'dart:async';

import 'package:flutter/services.dart';

import 'flutter_accelerometer_plugin_platform_interface.dart';

class FlutterAccelerometerPlugin {
  Future<String?> getPlatformVersion() {
    return FlutterAccelerometerPluginPlatform.instance.getPlatformVersion();
  }

//   static const MethodChannel _channel =
//   MethodChannel('flutter_accelerometer_plugin');
//
//   static Future<Map<String, double>?> getSensorData() async {
//     final data = await _channel.invokeMethod<Map>('getSensorData');
//     if (data == null) return null;
//     return {
//       'x': (data['x'] as num).toDouble(),
//       'y': (data['y'] as num).toDouble(),
//       'z': (data['z'] as num).toDouble(),
//     };
//   }
// }

  static const MethodChannel _channel = MethodChannel('flutter_accelerometer_plugin');

  static Future<void> startListening() async {
    await _channel.invokeMethod('startListening');
  }

  static Future<void> stopListening() async {
    await _channel.invokeMethod('stopListening');
  }

  // static Stream<Map<String, double>> get sensorStream {
  //   return _sensorEvents.stream;
  // }

  static final StreamController<Map<String, double>> _sensorController =
  StreamController<Map<String, double>>.broadcast();

  static Stream<Map<String, double>> get sensorStream => _sensorController.stream;

  static void _handleSensorEvent(dynamic event) {
    void _handleSensorEvent(dynamic event) {
      if (event is Map) {
        _sensorController.add({
          'x': (event['x'] as num).toDouble(),
          'y': (event['y'] as num).toDouble(),
          'z': (event['z'] as num).toDouble(),
        });
      }
    }
  }

  static void initialize() {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onSensorChanged') {
        _handleSensorEvent(call.arguments);
      }
    });
  }
}

void main() {
  FlutterAccelerometerPlugin.initialize();
}



// class FlutterAccelerometerPlugin {
//   static const MethodChannel _channel =
//   MethodChannel('flutter_accelerometer_plugin');
//
//   static Future<Map<String, double>?> getSensorData() async {
//     final data = await _channel.invokeMethod<Map>('getSensorData');
//     if (data == null) return null;
//     return {
//       'x': (data['x'] as num).toDouble(),
//       'y': (data['y'] as num).toDouble(),
//       'z': (data['z'] as num).toDouble(),
//     };
//   }
// }