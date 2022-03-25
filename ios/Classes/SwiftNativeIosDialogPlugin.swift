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
        case "showDialog":
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
        let title = args.value(forKey: "title") as! String
        let message = args.value(forKey: "message") as! String
        let style = args.value(forKey: "style") as! Int

        let alertStyle = indexToAlertStyle(style)
        if alertStyle == nil {
            result(invalidStyleError)
            return
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle!)

        let actions = args.value(forKey: "actions") as! [NSDictionary]

        for (index, action) in actions.enumerated() {
            let title = action.value(forKey: "text") as! String
            let enabled = action.value(forKey: "enabled") as! Bool

            let actionStyle = indexToActionStyle(action.value(forKey: "style") as! Int)
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


        /*
        let confirmAction = UIAlertAction(title: confirmButton, style: indexToStyle(confirmButtonStyle)) { _ in
            result(true)
        }
        alert.addAction(confirmAction)
        if showCancelButton {
            let cancelAction = UIAlertAction(title: cancelButton, style: indexToStyle(cancelButtonStyle)) { _ in
                result(false)
            }
            alert.addAction(cancelAction)
            let test = UIAlertAction(title: "lol a button", style: indexToStyle(cancelButtonStyle)) { _ in
                result(false)
            }
            alert.addAction(test)
        }
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Remind Me Tomorrow", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Launch the Missile", style: .destructive, handler: nil))
        */
        guard let controller = controller else {
            result(unavailableError)
            return
        }
        controller.present(alert, animated: true)


    }

}
