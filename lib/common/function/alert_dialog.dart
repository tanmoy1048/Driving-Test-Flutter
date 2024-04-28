import 'package:flutter/material.dart';

Future<void> showMyDialog({
  required BuildContext context,
  Widget? title,
  Widget? body,
  List<Widget>? actions,
  bool barrierDismissible = true,
  MainAxisAlignment? actionsAlignment,
  EdgeInsetsGeometry? contentPadding,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible,
    useRootNavigator: false,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: contentPadding,
        title: title,
        content: body,
        actions: actions,
        actionsAlignment: actionsAlignment,
      );
    },
  );
}
