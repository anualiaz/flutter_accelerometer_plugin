import Flutter
import UIKit
import CoreMotion

public class FlutterAccelerometerPlugin: NSObject, FlutterPlugin {
    private var motionManager: CMMotionManager?
    private var eventSink: FlutterEventSink?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_accelerometer_plugin", binaryMessenger: registrar.messenger())
        let eventChannel = FlutterEventChannel(name: "flutter_accelerometer_plugin_stream", binaryMessenger: registrar.messenger())

        let instance = FlutterAccelerometerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        eventChannel.setStreamHandler(instance)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "startListening":
            startListening()
            result("Listening started")
        case "stopListening":
            stopListening()
            result("Listening stopped")
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func startListening() {
        motionManager = CMMotionManager()
        motionManager?.accelerometerUpdateInterval = 0.1
        motionManager?.startAccelerometerUpdates(to: OperationQueue.main) { (data, error) in
            if let data = data, let sink = self.eventSink {
                let sensorData: [String: Double] = [
                    "x": data.acceleration.x,
                    "y": data.acceleration.y,
                    "z": data.acceleration.z
                ]
                sink(sensorData)
            }
        }
    }

    private func stopListening() {
        motionManager?.stopAccelerometerUpdates()
        motionManager = nil
    }
}

extension FlutterAccelerometerPlugin: FlutterStreamHandler {
    public func onListen(withArguments arguments: Any?, eventSink: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = eventSink
        startListening()
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        stopListening()
        eventSink = nil
        return nil
    }
}