import 'package:flutter/material.dart';

Future<bool> yesNoDialog(
  BuildContext context,
  String title,
  { Widget? child }
  ) async {
  final res = await showDialog<bool>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: child,
        actions: <Widget>[
          TextButton(
            child: const Text('Si'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ],
      );
    },
  );
  return (res == null) ? false : res;
}