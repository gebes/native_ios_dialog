import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:native_ios_dialog/exception.dart';

/// DTO for a NSButton
class NativeMacosDialogButton {
  /// Text of the button which is displayed
  final String text;

  /// If the button is not the first button, it can be destructive since macOS 11
  final bool destructive;

  /// Callback when the user clicks the button
  /// If this callback is null, then the button is disabled
  final VoidCallback? onPressed;

  NativeMacosDialogButton({required this.text, this.destructive = false, this.onPressed});

  /// Get if the button is enabled or not
  bool get enabled => onPressed != null;

  Map<dynamic, dynamic> toJson() {
    return {"text": text, "enabled": enabled, "destructive": destructive};
  }
}

/// Enum mapping for the [NSAlert.Style](https://developer.apple.com/documentation/appkit/nsalert/style)
enum NativeMacosDialogStyle { critical, informational, warning }

class NativeMacosDialog {
  static const MethodChannel _channel = MethodChannel('native_ios_dialog');

  /// Title of the dialog
  final String? title;

  /// Main content of the dialog
  final String? message;

  /// Style of the dialog, which determines the look and feel of the dialog
  final NativeMacosDialogStyle style;

  /// List of buttons that the dialog has.
  /// Please note that if there is no button, the user cannot close the dialog unless he closes the whole app.
  /// The same also applies when all buttons are disabled (`onPressed` is null)
  final List<NativeMacosDialogButton> buttons;

  NativeMacosDialog({
    this.title,
    this.message,
    this.style = NativeMacosDialogStyle.informational,
    required this.buttons,
  });

  /// Shows the native macOS Dialog and calls the specific `onPressed` handler
  ///
  /// [WrongPlatformException] if `.show()` was not called on a macOS Platform
  Future<void> show() async {
    if (!Platform.isMacOS) {
      throw WrongPlatformException("Platform needs to be macOS");
    }

    final result = await _channel.invokeMethod<int>("showDialogMacos", {
          "title": title,
          "message": message,
          "style": style.index,
          "buttons": [for (var button in buttons) button.toJson()]
        }) ??
        -1;
    if (result == -1) return;
    var button = buttons[result];
    if (!button.enabled || button.onPressed == null) return;
    button.onPressed!();
  }
}
