package com.example.flutter_minjing_stylish

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.util.Log

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.myapp/string"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getString" -> {
                    val stringValue = getStringFromAndroid()
                    result.success(stringValue)
                }
                "sendString" -> {
                    val stringValue = call.argument<String>("stringValue")
                    if (stringValue != null) {
                        handleStringFromFlutter(stringValue)
                        result.success(null)
                    } else {
                        result.error("INVALID_ARGUMENT", "String is null", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun getStringFromAndroid(): String {
        // Replace this with the actual string retrieval logic
        return "Hello from Jim's Android App!"
    }

    private fun handleStringFromFlutter(stringValue: String) {
        // Handle the received string from Flutter app
        Log.d("Flutter App", "getStringValue = " + stringValue)
    }
}
