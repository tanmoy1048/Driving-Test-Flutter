import 'package:flutter/material.dart';

Future<void> showMyDialog({
  required BuildContext context,
  Widget? title,
  Widget? body,
  List<Widget>? actions,
  bool barrierDismissible = true,
  MainAxisAlignment? actionsAlignment,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible,
    useRootNavigator: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: title,
        content: body,
        actions: actions,
        actionsAlignment: actionsAlignment,
      );
    },
  );
}
