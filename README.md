# Native iOS Dialog

A Flutter plugin which makes it straightforward to show the **native** equivalent of a [CupertinoAlertDialog](https://api.flutter.dev/flutter/cupertino/CupertinoAlertDialog-class.html) or [CupertinoActionSheet](https://api.flutter.dev/flutter/cupertino/CupertinoActionSheet-class.html) dialog.




##  Usage
To use this plugin, add `native_ios_dialog` as a dependency in your pubspec.yaml file.

Dialogs itself in Flutter are pretty awesome. However, the [CupertinoAlertDialogs](https://api.flutter.dev/flutter/cupertino/CupertinoAlertDialog-class.html) do not provide the same feeling as native iOS dialogs, so I created this plugin.
With this plugin, you have all the customization options iOS provides.

### Types of plugins
* Alert
* Action Sheet

### Types of buttons
* Default
* Destructive
* Cancel


### Sample Usage

#### Info dialog
```dart 
NativeIosDialog(title: "Info", message: "Please consider the following information in this dialog.", style: style, actions: [
  NativeIosDialogButton(text: "OK", style: NativeIosDialogButtonStyle.defaultStyle, onPressed: () {}),
]).show();
```

#### Confirm dialog
```dart
NativeIosDialog(title: "Confirm", message: "Please confirm the following information in this dialog.", style: style, actions: [
  NativeIosDialogButton(text: "OK", style: NativeIosDialogButtonStyle.defaultStyle, onPressed: () {}),
  NativeIosDialogButton(text: "Cancel", style: NativeIosDialogButtonStyle.cancel, onPressed: () {}),
]).show();
```