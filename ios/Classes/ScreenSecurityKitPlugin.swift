import Flutter
import UIKit
/// iOS implementation of the ScreenSecurityKit Flutter plugin.
///
/// Handles screenshot detection and communicates events to Flutter via EventChannel.
public class ScreenSecurityKitPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    /// Sink for sending screenshot events to Flutter.
    private var eventSink: FlutterEventSink?
    /// Registers the plugin with the Flutter plugin registrar.
    ///
    /// Sets up method and event channels for communication between Flutter and native iOS code.
    public static func register(with registrar: FlutterPluginRegistrar) {
        let methodChannel = FlutterMethodChannel(
            name: "com.example.screensecuritykit_rakibul25/methods",
            binaryMessenger: registrar.messenger())
        let eventChannel = FlutterEventChannel(
            name: "com.example.screensecuritykit_rakibul25/events",
            binaryMessenger: registrar.messenger())
        let instance = ScreenSecurityKitPlugin()
        registrar.addMethodCallDelegate(instance, channel: methodChannel)
        eventChannel.setStreamHandler(instance)
    }
    /// Handles method calls from Flutter.
    ///
    /// No-op for iOS as screen capture control is not supported natively.
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        // No-op for iOS
        result(nil)
    }
    /// Called when Flutter starts listening for screenshot events.
    ///
    /// Adds an observer for the screenshot notification and stores the event sink.
    public func onListen(
        withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink
    ) -> FlutterError? {
        self.eventSink = events
        NotificationCenter.default.addObserver(
            self, selector: #selector(screenshotTaken),
            name: UIApplication.userDidTakeScreenshotNotification, object: nil)
        return nil
    }
    /// Called when Flutter stops listening for screenshot events.
    ///
    /// Removes the screenshot notification observer and clears the event sink.
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        NotificationCenter.default.removeObserver(
            self, name: UIApplication.userDidTakeScreenshotNotification, object: nil)
        self.eventSink = nil
        return nil
    }
    /// Called when a screenshot is taken on the device.
    ///
    /// Emits a "screenshot" event to Flutter via the event sink.
    @objc private func screenshotTaken() {
        eventSink?("screenshot")
    }
}