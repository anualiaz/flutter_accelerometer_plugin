package com.example.flutter_accelerometer_plugin

import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class FlutterAccelerometerPlugin: FlutterPlugin, MethodChannel.MethodCallHandler, SensorEventListener {
  private lateinit var channel: MethodChannel
  private var sensorManager: SensorManager? = null
  private var accelerometer: Sensor? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_accelerometer_plugin")
    channel.setMethodCallHandler(this)

    sensorManager = flutterPluginBinding.applicationContext.getSystemService(Context.SENSOR_SERVICE) as SensorManager
    accelerometer = sensorManager?.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "startListening" -> {
        startListening()
        result.success("Listening started")
      }
      "stopListening" -> {
        stopListening()
        result.success("Listening stopped")
      }
      else -> result.notImplemented()
    }
  }

  private fun startListening() {
    sensorManager?.registerListener(this, accelerometer, SensorManager.SENSOR_DELAY_UI)
  }

  private fun stopListening() {
    sensorManager?.unregisterListener(this)
  }

  override fun onSensorChanged(event: SensorEvent?) {
    if (event != null) {
      val data = mapOf("x" to event.values[0], "y" to event.values[1], "z" to event.values[2])
      channel.invokeMethod("onSensorChanged", data)
    }
  }

  override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    stopListening()
    sensorManager = null
    accelerometer = null
  }
}