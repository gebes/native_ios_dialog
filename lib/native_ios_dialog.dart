import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

/// DTO for a UIAlertAction
class NativeIosDialogButton {
  /// Text of the button which is displayed
  final String text;

  /// Style of the buttonj
  final NativeIosDialogButtonStyle style;

  /// Callback when the user clicks the button
  /// If this callback is null, then the button is disabled
  final VoidCallback? onPressed;

  NativeIosDialogButton({required this.text, required this.style, this.onPressed});

  /// Get whetever the button is enabled or not
  bool get enabled => onPressed != null;

  Map<dynamic, dynamic> toJson() {
    return {"text": text, "style": style.index, "enabled": enabled};
  }
}

/// Enum mapping for the [UIAlertController.Style](https://developer.apple.com/documentation/uikit/uialertcontroller/style)
enum NativeIosDialogStyle {
  /// An action sheet displayed by the view controller that presented it.
  /// Is the native equivalent to [CupertinoActionSheet](https://api.flutter.dev/flutter/cupertino/CupertinoActionSheet-class.html)
  actionSheet,

  /// An alert displayed modally for the app.
  /// Is the native equivalent to [CupertinoAlertDialog](https://api.flutter.dev/flutter/cupertino/CupertinoAlertDialog-class.html)
  alert
}

/// Enum mapping for the [UIAlertAction.Style](https://developer.apple.com/documentation/uikit/uialertaction/style)
enum NativeIosDialogButtonStyle {
  /// Apply the default style to the action’s button.
  defaultStyle,

  /// Apply a style that indicates the action cancels the operation and leaves things unchanged.
  cancel,

  /// Apply a style that indicates the action might change or delete data.
  destructive,
}

class NativeIosDialog {
  static const MethodChannel _channel = MethodChannel('native_ios_dialog');

  /// Title of the dialog
  final String title;

  /// Main content of the dialog
  final String message;

  /// Style of the dialog, which determines if it is the native equivalent to a [CupertinoAlertDialog](https://api.flutter.dev/flutter/cupertino/CupertinoAlertDialog-class.html) or [CupertinoActionSheet](https://api.flutter.dev/flutter/cupertino/CupertinoActionSheet-class.html)
  final NativeIosDialogStyle style;

  /// List of actions that the dialog has.
  /// Please note that if there is no action, the user cannot close the dialog unless he closes the whole app.
  /// The same also applies when all actions are disabled (`onPressed` is null)
  final List<NativeIosDialogButton> actions;

  NativeIosDialog({required this.title, required this.message, this.style = NativeIosDialogStyle.alert, required this.actions});

  /// Shows the native iOS Dialog and calls the specific `onPressed` handler
  ///
  /// [WrongPlatformException] if `.show()` was not called on a iOS Platform
  Future<void> show() async {
    if (!Platform.isIOS) {
      throw WrongPlatformException("Platform needs to be iOS");
    }

    final result = await _channel.invokeMethod<int>("showDialog", {
          "title": title,
          "message": message,
          "style": style.index,
          "actions": [for (var action in actions) action.toJson()]
        }) ??
        -1;
    if (result == -1) return;
    var action = actions[result];
    if (!action.enabled || action.onPressed == null) return;
    action.onPressed!();
  }
}

/// This exception is thrown, when `.show()` is called on a different platform
class WrongPlatformException implements Exception {
  String cause;

  WrongPlatformException(this.cause);
}
