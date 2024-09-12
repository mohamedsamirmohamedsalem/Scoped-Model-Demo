import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final String? positiveButtonText;
  final VoidCallback? onPositiveButtonPressed;
  final String? negativeButtonText;
  final VoidCallback? onNegativeButtonPressed;

  CustomDialog({
    required this.title,
    required this.content,
    this.positiveButtonText,
    this.onPositiveButtonPressed,
    this.negativeButtonText,
    this.onNegativeButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        if (negativeButtonText != null)
          TextButton(
            onPressed: onNegativeButtonPressed ?? () => Navigator.of(context).pop(),
            child: Text(negativeButtonText!),
          ),
        if (positiveButtonText != null)
          TextButton(
            onPressed: onPositiveButtonPressed ?? () => Navigator.of(context).pop(),
            child: Text(positiveButtonText!),
          ),
      ],
    );
  }
}
