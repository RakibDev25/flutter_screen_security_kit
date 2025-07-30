import Flutter
import UIKit

public class ScreenSecurityKitPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
  private var eventSink: FlutterEventSink?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let methodChannel = FlutterMethodChannel(name: "com.example.screensecuritykit_rakibul25/methods", binaryMessenger: registrar.messenger())
    let eventChannel = FlutterEventChannel(name: "com.example.screensecuritykit_rakibul25/events", binaryMessenger: registrar.messenger())
    let instance = ScreenSecurityKitPlugin()
    registrar.addMethodCallDelegate(instance, channel: methodChannel)
    eventChannel.setStreamHandler(instance)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    // No-op for iOS
    result(nil)
  }

  public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    self.eventSink = events
    NotificationCenter.default.addObserver(self, selector: #selector(screenshotTaken), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
    return nil
  }

  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    NotificationCenter.default.removeObserver(self, name: UIApplication.userDidTakeScreenshotNotification, object: nil)
    self.eventSink = nil
    return nil
  }

  @objc private func screenshotTaken() {
    eventSink?("screenshot")
  }
}