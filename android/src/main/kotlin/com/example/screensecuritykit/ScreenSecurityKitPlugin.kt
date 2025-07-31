package com.example.screensecuritykit

import android.app.Activity
import android.view.WindowManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

/**
 * Android implementation of the ScreenSecurityKit Flutter plugin.
 *
 * Handles enabling and disabling screen capture (screenshots and recordings)
 * by setting or clearing the FLAG_SECURE window flag on the current activity.
 */
class ScreenSecurityKitPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// Channel for communicating with Flutter via method calls.
    private lateinit var channel: MethodChannel

    /// Reference to the current Android activity.
    private var activity: Activity? = null

    /**
     * Called when the plugin is attached to the Flutter engine.
     *
     * Sets up the method channel for communication with Dart code.
     */
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(
            flutterPluginBinding.binaryMessenger,
            "com.example.screensecuritykit_rakibul25/methods"
        )
        channel.setMethodCallHandler(this)
    }

    /**
     * Handles method calls from Flutter.
     *
     * - "disableScreenCapture": Sets FLAG_SECURE to prevent screenshots/recordings.
     * - "enableScreenCapture": Clears FLAG_SECURE to allow screenshots/recordings.
     */
    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        when (call.method) {
            "disableScreenCapture" -> {
                activity?.window?.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
                result.success(null)
            }

            "enableScreenCapture" -> {
                activity?.window?.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
                result.success(null)
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    /**
     * Called when the plugin is detached from the Flutter engine.
     *
     * Cleans up the method call handler.
     */
    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    /**
     * Called when the plugin is attached to an activity.
     *
     * Stores a reference to the current activity.
     */
    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    /**
     * Called when the activity is detached for configuration changes.
     *
     * Clears the activity reference.
     */
    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    /**
     * Called when the activity is reattached after configuration changes.
     *
     * Updates the activity reference.
     */
    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    /**
     * Called when the plugin is detached from the activity.
     *
     * Clears the activity reference.
     */
    override fun onDetachedFromActivity() {
        activity = null
    }
}