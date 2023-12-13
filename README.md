# Native iOS Dialog

A Flutter plugin which makes it straightforward to show the **native** equivalent of a [CupertinoAlertDialog](https://api.flutter.dev/flutter/cupertino/CupertinoAlertDialog-class.html) or [CupertinoActionSheet](https://api.flutter.dev/flutter/cupertino/CupertinoActionSheet-class.html) dialog.

##  Usage
To use this plugin, add `native_ios_dialog` as a dependency in your pubspec.yaml file.

Dialogs itself in Flutter are pretty awesome. However, the [CupertinoAlertDialogs](https://api.flutter.dev/flutter/cupertino/CupertinoAlertDialog-class.html) do not provide the same feeling as native iOS dialogs, so I created this plugin.
With this plugin, you have all the customization options iOS provides.

### Types of dialogs
* Alert 
* Action Sheet
<p float="left">
<img src="https://user-images.githubusercontent.com/35232234/160130532-380a5dbf-683b-4a4f-bfaa-f1ab2f727590.png" width="250">
<img src="https://user-images.githubusercontent.com/35232234/160130466-d82edd40-badd-4f89-a10f-4d37bff98e64.png" width="250">
</p>

### Types of buttons
* Default
* Destructive
* Cancel

Each button can also be disabled
<p float="left">
<img src="https://user-images.githubusercontent.com/35232234/160131143-510c5040-7c75-47dd-87e2-e0468680ccd6.png" width="250">
<img src="https://user-images.githubusercontent.com/35232234/160130517-f4e7b449-c007-4d85-8ab4-0d6c00f27e38.png" width="250">
<img src="https://user-images.githubusercontent.com/35232234/160130504-074a2ffb-7739-4388-aa1d-20fecb17e6ae.png" width="250">
</p>

### Sample Usage

#### Info dialog
```dart 
NativeIosDialog(title: "Info", message: "Please consider the following information in this dialog.", style: style, actions: [
  NativeIosDialogAction(text: "OK", style: NativeIosDialogActionStyle.defaultStyle, onPressed: () {}),
]).show();
```

#### Confirm dialog
```dart
NativeIosDialog(title: "Confirm", message: "Please confirm the following information in this dialog.", style: style, actions: [
  NativeIosDialogAction(text: "OK", style: NativeIosDialogActionStyle.defaultStyle, onPressed: () {}),
  NativeIosDialogAction(text: "Cancel", style: NativeIosDialogActionStyle.cancel, onPressed: () {}),
]).show();
```