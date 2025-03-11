import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_accelerometer_plugin/flutter_accelerometer_plugin.dart';
import 'package:flutter_accelerometer_plugin_example/sensor_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SensorScreen(),
    );
  }
}

class SensorScreen extends StatefulWidget {
  @override
  State<SensorScreen> createState() => _SensorScreenState();
}

class _SensorScreenState extends State<SensorScreen> {
  final SensorController controller = Get.put(SensorController());


  @override
  void initState() {
    FlutterAccelerometerPlugin.sensorStream.listen((event) {
      print("Accelerometer Data: X=${event['x']}, Y=${event['y']}, Z=${event['z']}");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Accelerometer Sensor")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text("X: ${controller.x.value}", style: TextStyle(fontSize: 18))),
            Obx(() => Text("Y: ${controller.y.value}", style: TextStyle(fontSize: 18))),
            Obx(() => Text("Z: ${controller.z.value}", style: TextStyle(fontSize: 18))),
            SizedBox(height: 20),
            ElevatedButton(onPressed: controller.startListening, child: Text("Start")),
            ElevatedButton(onPressed: controller.stopListening, child: Text("Stop")),
          ],
        ),
      ),
    );
  }
}

