import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

String formatDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  String formattedDate = DateFormat.yMMMMd().format(dateTime);

  return formattedDate;
}

void showSnackBar(context, {required String message, bool success = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 700),
      content: Text(message),
      backgroundColor: success ? Colors.green : Colors.red,
    ),
  );
}

Future<void> showAlertDialog(BuildContext context,
    {String? title,
    required Widget body,
    bool withButton = true,
    bool withCancel = true,
    Widget? button,
    String? cancelTitle,
    String? okTitle,
    VoidCallback? okPressed}) async {
  await showPlatformDialog(
    context: context,
    androidBarrierDismissible: false,
    builder: (_) => BasicDialogAlert(
      title: Text(
        title ?? "Confirmation",
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: body,
      actions: [
        if (withCancel)
          BasicDialogAction(
            title: Text(
              cancelTitle ?? 'Cancel',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        BasicDialogAction(
          title: Text(
            okTitle ?? 'ok',
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
          onPressed: okPressed ?? () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}
