import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String? content;

  const ErrorDialog({this.title = 'Error', required this.content});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoAlertDialog(
            title: Text('Error'),
            content: Text(content!),
            actions: [
              CupertinoDialogAction(
                  child: const Text('Ok'),
                  onPressed: () => Navigator.of(context).pop())
            ],
          )
        : AlertDialog(
            title: Text('Error'),
            content: Text(content!),
            actions: [
              TextButton(
                  child: const Text('Ok'),
                  onPressed: () => Navigator.of(context).pop())
            ],
          );
  }
}
