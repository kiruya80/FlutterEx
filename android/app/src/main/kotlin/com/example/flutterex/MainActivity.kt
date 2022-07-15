package com.example.flutterex

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.util.Log
import androidx.annotation.NonNull
import org.json.JSONObject
import org.json.JSONArray
import org.json.JSONException
import android.content.Intent
import android.os.Bundle

class MainActivity: FlutterActivity() {
    private val TAG = "MainActivity"
    private val CHANNEL = "com.example.flutterex/client"
    private lateinit var _result: MethodChannel.Result
    private val intents = mutableMapOf<String, String?>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        printAllIntentParams()
//        setIntentInfos()
    }

    private fun setIntentInfos() {
        val _bundle = intent.extras

        if(_bundle == null) {
            return
        }

        for (key in _bundle.keySet()) {
            intents[key] = intent.getStringExtra(key)
        }

        Log.i(TAG, " ItentValues: ${intents.toString()}")
    }

    private fun printAllIntentParams() {
        val _bundle = intent.extras

        if(_bundle == null) {
            return
        }

        var _value : String = "Bundle {"
        for (key in _bundle.keySet()) {
            _value += "\n    " + key + " => " + _bundle.get(key) + ";"
        }
        _value += "\n}"
        Log.i(TAG, _value)
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)


        val channelNative = MethodChannel(flutterEngine.getDartExecutor(), CHANNEL)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            Log.e(TAG, "call.method ==== " + call.method.toString())

            if (call.method.contentEquals("getIntentValues")) {
                Log.e(TAG, "call.method :!!!! getIntentValues ")
                result.success(JSONObject(intents as Map<*, *>).toString())

            } else  if (call.method.contentEquals("sendFcmMsg")) {
                Log.e(TAG, "call.method :!!!! sendFcmMsg ")

            } else {
                result.notImplemented();
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        Log.d(TAG, "MainActivity SplashActivity:: requestCode = $requestCode, resultCode = $resultCode")
    }
}
