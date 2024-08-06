package com.example.vazifa35

import android.content.Context
import android.hardware.camera2.CameraAccessException
import android.hardware.camera2.CameraManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.flashlight_app/flashlight"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "turnOnFlashlight" -> {
                        toggleFlashlight(true)
                        result.success(null)
                    }
                    "turnOffFlashlight" -> {
                        toggleFlashlight(false)
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun toggleFlashlight(isOn: Boolean) {
        val cameraManager = getSystemService(Context.CAMERA_SERVICE) as CameraManager
        val cameraId = cameraManager.cameraIdList.firstOrNull() ?: return
        try {
            cameraManager.setTorchMode(cameraId, isOn)
        } catch (e: CameraAccessException) {
            e.printStackTrace()
        }
    }
}
