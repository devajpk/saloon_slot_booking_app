import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showLogoutConfirmation(BuildContext context, VoidCallback onConfirm) async {
  return showCupertinoDialog(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: const Text("Log out"),
      content: const Text("Are you sure you want to log out?"),
      actions: [
        CupertinoDialogAction(
          child: const Text("Cancel"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          child: const Text("Log out"),
          onPressed: () {
            onConfirm(); 
          },
        ),
      ],
    ),
  );
}
