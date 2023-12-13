import Flutter
import UIKit

public class SwiftNativeIosDialogPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "native_ios_dialog", binaryMessenger: registrar.messenger())
        let instance = SwiftNativeIosDialogPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "showDialogIos":
            let exception = tryBlock {
                self.showDialog(call, result)
            }
            if exception != nil {
                result(FlutterError(code: "DIALOG_ERROR", message: exception!.reason, details: nil))
                return
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private var controller: UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }

    private var okText: String {
        return NSLocalizedString("OK", comment: "OK")
    }

    private var cancelText: String {
        return NSLocalizedString("Cancel", comment: "Cancel")
    }

    private var unavailableError: FlutterError {
        return FlutterError(code: "UNAVAILABLE", message: "Native alert is unavailable", details: nil)
    }
    private var invalidStyleError: FlutterError {
        return FlutterError(code: "INVALID_STYLE", message: "Given index for style is invalid", details: nil)
    }

    private func indexToActionStyle(_ index: Int) -> UIAlertAction.Style? {
        switch index {
        case 0:
            return .default
        case 1:
            return .cancel
        case 2:
            return .destructive
        default:
            return nil
        }
    }

    private func indexToAlertStyle(_ index: Int) -> UIAlertController.Style? {
        switch index {
        case 0:
            return .actionSheet
        case 1:
            return .alert
        default:
            return nil
        }
    }

    private func showDialog(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! NSDictionary
        let title = args.value(forKey: "title") as? String ?? nil
        let message = args.value(forKey: "message") as? String ?? nil
        let style = args.value(forKey: "style") as! Int

        var alertStyle = indexToAlertStyle(style)
        if alertStyle == nil {
            result(invalidStyleError)
            return
        }

        // Check if the device is an iPad and the style is .actionSheet
        // .actionSheet is not supported on iPadOS since 13.2
        if UIDevice.current.userInterfaceIdiom == .pad && alertStyle == .actionSheet {
            alertStyle = .alert
        }

        let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle!)

        let actions = args.value(forKey: "actions") as! [NSDictionary]

        for (index, action) in actions.enumerated() {
            let title = action.value(forKey: "text") as! String
            let enabled = action.value(forKey: "enabled") as! Bool

            var actionStyle = indexToActionStyle(action.value(forKey: "style") as! Int)
            if actionStyle == nil {
                result(invalidStyleError)
                return
            }

            let alertAction = UIAlertAction(title: title, style: actionStyle!, handler: { _ in
                result(index)
            })
            alertAction.isEnabled = enabled
            alert.addAction(alertAction)

        }

        guard let controller = controller else {
            result(unavailableError)
            return
        }
        controller.present(alert, animated: true)
    }

}
