package com.example.flutter_minjing_stylish

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.util.Log
import tech.cherri.tpdirect.api.TPDServerType
import tech.cherri.tpdirect.api.TPDSetup

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.myapp/string"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        TPDSetup.initInstance(
            this,
            12348,
            "app_pa1pQcKoY22IlnSXq5m5WP5jFKzoRG58VEXpT7wU62ud7mMbDOGzCYIlzzLF",
            TPDServerType.Sandbox
        )
    }

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
                "tappay" -> {
                    Log.d("Jim's Android App", "tappay")

                    val dialog = PrimeDialog(context, object : PrimeDialog.PrimeDialogListener {
                        override fun onSuccess(prime: String) {
                            Log.d(TAG, "onSuccess, prime = $prime")
                            result.success(prime)
                        }

                        override fun onFailure(error: String) {
                            Log.d(TAG, "onFailure, error = $error")
                            result.success(error)
                        }

                    })

                    dialog.show()
                }
                else -> {
                    Log.d(TAG, "unknown method: ${call.method}")
                    result.notImplemented()
                }
            }
        }
    }

    private fun getStringFromAndroid(): String {
        // Replace this with the actual string retrieval logic
        return "Hello from Jim's Android App!"
    }

    private fun handleStringFromFlutter(stringValue: String) {
        // Handle the received string from Flutter app
        Log.d("Jim's Android App", "getStringValue = $stringValue")
    }

    companion object {
        const val TAG = "MainActivity"
    }
}
