import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:native_ios_dialog/native_ios_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentDialogStyle = 0;

  @override
  Widget build(BuildContext context) {
    final NativeIosDialogStyle style = currentDialogStyle == 0
        ? NativeIosDialogStyle.alert
        : NativeIosDialogStyle.actionSheet;
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Native iOS Dialogs"),
      ),
      child: ListView(
        children: [
          const SizedBox(height: 12),
          const SimpleDivider(text: "Basic examples"),
          SimpleButton(
            text: "Info Dialog",
            onPressed: () {
              NativeIosDialog(
                  title: "Info",
                  message:
                      "Please consider the following information in this dialog.",
                  style: style,
                  actions: [
                    NativeIosDialogAction(
                        text: "OK",
                        style: NativeIosDialogActionStyle.defaultStyle,
                        onPressed: () {}),
                  ]).show();
            },
          ),
          SimpleButton(
            text: "Confirm Dialog",
            onPressed: () {
              NativeIosDialog(
                  title: "Confirm",
                  message:
                      "Please confirm the following information in this dialog.",
                  style: style,
                  actions: [
                    NativeIosDialogAction(
                        text: "OK",
                        style: NativeIosDialogActionStyle.defaultStyle,
                        onPressed: () {}),
                    NativeIosDialogAction(
                        text: "Cancel",
                        style: NativeIosDialogActionStyle.cancel,
                        onPressed: () {}),
                  ]).show();
            },
          ),
          SimpleButton(
            text: "Destructive Confirm Dialog",
            onPressed: () {
              NativeIosDialog(
                  title: "Confirm deletion",
                  message:
                      "Do you want to delete this resource? You cannot undo this action.",
                  style: style,
                  actions: [
                    NativeIosDialogAction(
                        text: "Delete",
                        style: NativeIosDialogActionStyle.destructive,
                        onPressed: () {}),
                    NativeIosDialogAction(
                        text: "Cancel",
                        style: NativeIosDialogActionStyle.cancel,
                        onPressed: () {}),
                  ]).show();
            },
          ),
          SimpleButton(
            text: "Three Buttons",
            onPressed: () {
              NativeIosDialog(
                  title: "Are you sure?",
                  message:
                      "Do you want to apply the changes you made, or do you want to delete this resource?",
                  style: style,
                  actions: [
                    NativeIosDialogAction(
                        text: "Apply",
                        style: NativeIosDialogActionStyle.defaultStyle,
                        onPressed: () {}),
                    NativeIosDialogAction(
                        text: "Delete",
                        style: NativeIosDialogActionStyle.destructive,
                        onPressed: () {}),
                    NativeIosDialogAction(
                        text: "Cancel",
                        style: NativeIosDialogActionStyle.cancel,
                        onPressed: () {}),
                  ]).show();
            },
          ),
          const SimpleDivider(text: "Examples with disabled actions"),
          SimpleButton(
            text: "Confirm Dialog",
            onPressed: () {
              NativeIosDialog(
                  title: "Confirm",
                  message:
                      "Please confirm the following information in this dialog.\n\nOh wait!\nSeems like there is something that prohibits you from confirming this dialog.",
                  style: style,
                  actions: [
                    NativeIosDialogAction(
                        text: "OK",
                        style: NativeIosDialogActionStyle.defaultStyle),
                    NativeIosDialogAction(
                        text: "Cancel",
                        style: NativeIosDialogActionStyle.cancel,
                        onPressed: () {}),
                  ]).show();
            },
          ),
          SimpleButton(
            text: "Destructive Confirm Dialog",
            onPressed: () {
              NativeIosDialog(
                  title: "Confirm deletion",
                  message:
                      "Do you want to delete this resource? You cannot undo this action.\n\nOh wait!\nSeems like there is something that prohibits you from confirming this dialog.",
                  style: style,
                  actions: [
                    NativeIosDialogAction(
                        text: "Delete",
                        style: NativeIosDialogActionStyle.destructive),
                    NativeIosDialogAction(
                        text: "Cancel",
                        style: NativeIosDialogActionStyle.cancel,
                        onPressed: () {}),
                  ]).show();
            },
          ),
          SimpleButton(
            text: "Three Buttons",
            onPressed: () {
              NativeIosDialog(
                  title: "Are you sure?",
                  message:
                      "Do you want to apply the changes you made, or do you want to delete this resource?",
                  style: style,
                  actions: [
                    NativeIosDialogAction(
                        text: "Apply",
                        style: NativeIosDialogActionStyle.defaultStyle),
                    NativeIosDialogAction(
                        text: "Delete",
                        style: NativeIosDialogActionStyle.destructive),
                    NativeIosDialogAction(
                        text: "Cancel",
                        style: NativeIosDialogActionStyle.cancel,
                        onPressed: () {}),
                  ]).show();
            },
          ),
          const SimpleDivider(text: "Other"),
          SimpleButton(
            text: "100 Buttons",
            onPressed: () {
              NativeIosDialog(
                  title: "Uhm...",
                  message:
                      "Please do not use this in production... please do not do this! This dialog is just a demonstration of how iOS handles many buttons.",
                  style: style,
                  actions: [
                    for (int i = 1; i <= 100; i++)
                      NativeIosDialogAction(
                          text: "Action $i",
                          style: NativeIosDialogActionStyle.defaultStyle,
                          onPressed: () {}),
                    NativeIosDialogAction(
                        text: "Cancel",
                        style: NativeIosDialogActionStyle.cancel,
                        onPressed: () {}),
                  ]).show();
            },
          ),
          const SimpleDivider(text: "Configuration"),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
            child: CupertinoSlidingSegmentedControl(
                groupValue: currentDialogStyle,
                children: const {0: Text("Alert"), 1: Text("ActionSheet")},
                onValueChanged: (int? newValue) {
                  if (newValue == null) return;
                  setState(() {
                    currentDialogStyle = newValue;
                  });
                }),
          )
        ],
      ),
    );
  }
}

class SimpleButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SimpleButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: CupertinoButton(
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
        color: Theme.of(context).primaryColor,
        onPressed: onPressed,
      ),
    );
  }
}

class SimpleDivider extends StatelessWidget {
  final String text;

  const SimpleDivider({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        const Expanded(
            child: Divider(
          color: Colors.black,
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ),
        const Expanded(
            child: Divider(
          color: Colors.black,
        )),
      ]),
    );
  }
}
