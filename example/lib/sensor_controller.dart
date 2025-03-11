/// Created by Anu Alias on 10-03-2025.

import 'package:flutter/services.dart';
import 'package:flutter_accelerometer_plugin/flutter_accelerometer_plugin.dart';
import 'package:get/get.dart';

class SensorController extends GetxController {
  static const MethodChannel _channel = MethodChannel('flutter_accelerometer_plugin');

  var x = 0.0.obs;
  var y = 0.0.obs;
  var z = 0.0.obs;
  var isListening = false.obs;

  @override
  void onInit() {
    super.onInit();
    _channel.setMethodCallHandler((call) async {
      if (call.method == "onSensorChanged") {
        var data = call.arguments as Map<dynamic, dynamic>;
        x.value = (data['x'] as double);
        y.value = (data['y'] as double);
        z.value = (data['z'] as double);
      }
    });
  }

  Future<void> startListening() async {
    await _channel.invokeMethod('startListening');
    isListening.value = true;
  }

  Future<void> stopListening() async {
    await _channel.invokeMethod('stopListening');
    isListening.value = false;
  }
}