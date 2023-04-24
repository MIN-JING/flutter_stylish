package com.example.flutter_minjing_stylish

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.myapp/string"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getString") {
                val stringValue = getStringFromAndroid()
                result.success(stringValue)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getStringFromAndroid(): String {
        // Replace this with the actual string retrieval logic
        return "Hello from Jim's Android App!"
    }
}
