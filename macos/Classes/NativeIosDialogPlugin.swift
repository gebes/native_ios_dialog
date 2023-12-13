import Cocoa
import FlutterMacOS

public class NativeIosDialogPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "native_ios_dialog", binaryMessenger: registrar.messenger)
    let instance = NativeIosDialogPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }


    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "showDialogMacos":
            self.showDialog(call, result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private var window: NSWindow? {
        return NSApplication.shared.windows.first
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

   private func indexToAlertStyle(_ index: Int) -> NSAlert.Style? {
        switch index {
        case 0:
            return .critical
        case 1:
            return .informational
        case 2:
            return .warning
        default:
            return nil
        }
    }

    private func showDialog(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! NSDictionary
        let title = args.value(forKey: "title") as? String ?? nil
        let message = args.value(forKey: "message") as? String ?? nil
        let style = args.value(forKey: "style") as! Int

        let alertStyle = indexToAlertStyle(style)
        if alertStyle == nil {
            result(invalidStyleError)
            return
        }
        let alert = NSAlert()
        alert.messageText = title ?? ""
        alert.informativeText = message ?? ""
        alert.alertStyle = alertStyle!

        let buttons = args.value(forKey: "buttons") as! [NSDictionary]

        for (_, button) in buttons.enumerated() {
            let title = button.value(forKey: "text") as! String
            let enabled = button.value(forKey: "enabled") as! Bool
            let destructive = button.value(forKey: "destructive") as! Bool

        	let alertButton = NSButton(title: title, target: nil, action: nil)
            alertButton.isEnabled = enabled
			if #available(macOS 11.0, *) {
				alertButton.hasDestructiveAction = destructive
			}

            alert.addButton(withTitle: title)
        }

        guard let window = window else {
            result(unavailableError)
            return
        }
        alert.beginSheetModal(for: window) { (response) in
            let resultIndex = Int(response.rawValue) - Int(NSApplication.ModalResponse.alertFirstButtonReturn.rawValue)
            result(resultIndex)
        }
    }

}
