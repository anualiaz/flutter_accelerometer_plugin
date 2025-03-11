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

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
// //   String _platformVersion = 'Unknown';
// //   final _flutterAccelerometerPlugin = FlutterAccelerometerPlugin();
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     initPlatformState();
// //   }
// //
// //   // Platform messages are asynchronous, so we initialize in an async method.
// //   Future<void> initPlatformState() async {
// //     String platformVersion;
// //     // Platform messages may fail, so we use a try/catch PlatformException.
// //     // We also handle the message potentially returning null.
// //     try {
// //       platformVersion =
// //           await _flutterAccelerometerPlugin.getPlatformVersion() ?? 'Unknown platform version';
// //     } on PlatformException {
// //       platformVersion = 'Failed to get platform version.';
// //     }
// //
// //     // If the widget was removed from the tree while the asynchronous platform
// //     // message was in flight, we want to discard the reply rather than calling
// //     // setState to update our non-existent appearance.
// //     if (!mounted) return;
// //
// //     setState(() {
// //       _platformVersion = platformVersion;
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: const Text('Plugin example app'),
// //         ),
// //         body: Center(
// //           child: Text('Running on: $_platformVersion\n'),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//   double? x, y, z;
//
//   Future<void> fetchAccelerometerData() async {
//     final data = await FlutterAccelerometerPlugin.getSensorData();
//     if (data != null) {
//       setState(() {
//         x = data['x'];
//         y = data['y'];
//         z = data['z'];
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     fetchAccelerometerData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(title: Text('Accelerometer Plugin')),
//         body: Center(
//           child: x != null
//               ? Text('X: $x, Y: $y, Z: $z')
//               : CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }
// }