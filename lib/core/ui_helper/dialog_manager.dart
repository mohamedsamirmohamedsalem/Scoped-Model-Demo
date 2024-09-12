import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

class DialogsManager {
  static showAlert(BuildContext context, String title, String content) {
    showPlatformDialog(
      context: context,
      builder: (_) => BasicDialogAlert(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          BasicDialogAction(
            title: Text("ok".tr()),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  static showAlertWithAction(BuildContext context, String title, String content,
      {Function()? onPressed}) {
    showPlatformDialog(
      context: context,
      builder: (_) => BasicDialogAlert(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          BasicDialogAction(
            title: Text("ok".tr()),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }

  static showAlertWith2Action(
      BuildContext context, String title, String content,
      {Function()? onPressed}) {
    showPlatformDialog(
      context: context,
      builder: (_) => BasicDialogAlert(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          BasicDialogAction(
            title: Text("ok".tr()),
            onPressed: onPressed,
          ),
          BasicDialogAction(
            title: Text("cancel".tr()),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  static showConfirmationAlert(
      BuildContext context, String title, String content) {
    showPlatformDialog(
      context: context,
      builder: (_) => BasicDialogAlert(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          BasicDialogAction(
            title: Text("ok".tr()),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          BasicDialogAction(
            title: Text("cancel".tr()),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
