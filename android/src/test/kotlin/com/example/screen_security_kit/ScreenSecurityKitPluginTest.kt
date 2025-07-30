package com.example.screensecuritykit

import android.app.Activity
import android.view.WindowManager
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.junit.Before
import org.junit.Test
import org.mockito.Mockito.*

class ScreenSecurityKitPluginTest {

  private lateinit var plugin: ScreenSecurityKitPlugin
  private lateinit var mockMethodChannel: MethodChannel
  private lateinit var mockActivity: Activity
  private lateinit var mockActivityPluginBinding: ActivityPluginBinding
  private lateinit var mockWindow: WindowManager.LayoutParams

  @Before
  fun setUp() {
    plugin = ScreenSecurityKitPlugin()
    mockMethodChannel = mock(MethodChannel::class.java)
    mockActivity = mock(Activity::class.java)
    mockActivityPluginBinding = mock(ActivityPluginBinding::class.java)
    mockWindow = mock(WindowManager.LayoutParams::class.java)

    // Mock the activity and its window properties
    `when`(mockActivityPluginBinding.activity).thenReturn(mockActivity)
    `when`(mockActivity.window).thenReturn(mock(android.view.Window::class.java))
    `when`(mockActivity.window.attributes).thenReturn(mockWindow) // Mock attributes if needed
    `when`(mockActivity.application).thenReturn(mock(android.app.Application::class.java))

    // Attach the plugin to a mock activity
    plugin.onAttachedToActivity(mockActivityPluginBinding)
    plugin.onAttachedToEngine(mock(io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding::class.java).apply {
      `when`(binaryMessenger).thenReturn(mock(io.flutter.plugin.common.BinaryMessenger::class.java))
    })
    plugin.channel = mockMethodChannel // Set the mock channel for testing
  }

  @Test
  fun preventScreenshotAndRecording_enableTrue_addsFlagSecure() {
    val call = MethodCall("preventScreenshotAndRecording", mapOf("enable" to true))
    val result = mock(MethodChannel.Result::class.java)

    plugin.onMethodCall(call, result)

    verify(mockActivity.window).addFlags(WindowManager.LayoutParams.FLAG_SECURE)
    verify(result).success(null)
  }

  @Test
  fun preventScreenshotAndRecording_enableFalse_clearsFlagSecure() {
    val call = MethodCall("preventScreenshotAndRecording", mapOf("enable" to false))
    val result = mock(MethodChannel.Result::class.java)

    plugin.onMethodCall(call, result)

    verify(mockActivity.window).clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
    verify(result).success(null)
  }

  @Test
  fun setAppSwitchingMode_setsMode() {
    val call = MethodCall("setAppSwitchingMode", mapOf("mode" to "blur"))
    val result = mock(MethodChannel.Result::class.java)

    plugin.onMethodCall(call, result)

    // In the current implementation, setAppSwitchingMode primarily updates an internal variable.
    // If it were to directly manipulate window flags or add views, we would verify those interactions.
    // For this test, we can only verify that the method was called and returned success.
    verify(result).success(null)
  }

  @Test
  fun isScreenRecordingActive_returnsFalseOnAndroid() {
    val call = MethodCall("isScreenRecordingActive", null)
    val result = mock(MethodChannel.Result::class.java)

    plugin.onMethodCall(call, result)

    verify(result).success(false) // Android does not have a direct API for this detection
  }

  @Test
  fun onDetachedFromActivity_unregistersLifecycleCallbacks() {
    plugin.onDetachedFromActivity()
    verify(mockActivity.application).unregisterActivityLifecycleCallbacks(plugin)
    // Verify activity is nullified
    val activityField = ScreenSecurityKitPlugin::class.java.getDeclaredField("activity")
    activityField.isAccessible = true
    assert(activityField.get(plugin) == null)
  }

  @Test
  fun onDetachedFromEngine_setsMethodCallHandlerToNull() {
    plugin.onDetachedFromEngine(mock(io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding::class.java))
    verify(mockMethodChannel).setMethodCallHandler(null)
  }
}