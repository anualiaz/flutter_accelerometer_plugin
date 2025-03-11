import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_accelerometer_plugin/flutter_accelerometer_plugin.dart';
import 'package:flutter_accelerometer_plugin/flutter_accelerometer_plugin_platform_interface.dart';
import 'package:flutter_accelerometer_plugin/flutter_accelerometer_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterAccelerometerPluginPlatform
    with MockPlatformInterfaceMixin
    implements FlutterAccelerometerPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterAccelerometerPluginPlatform initialPlatform = FlutterAccelerometerPluginPlatform.instance;

  test('$MethodChannelFlutterAccelerometerPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterAccelerometerPlugin>());
  });

  test('getPlatformVersion', () async {
    FlutterAccelerometerPlugin flutterAccelerometerPlugin = FlutterAccelerometerPlugin();
    MockFlutterAccelerometerPluginPlatform fakePlatform = MockFlutterAccelerometerPluginPlatform();
    FlutterAccelerometerPluginPlatform.instance = fakePlatform;

    expect(await flutterAccelerometerPlugin.getPlatformVersion(), '42');
  });
}
