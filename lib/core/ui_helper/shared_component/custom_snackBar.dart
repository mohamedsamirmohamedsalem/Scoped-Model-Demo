import '../../logic_helper/import_all.dart';

abstract class CustomSnackBar {
  static void showSnackBarAsBottomSheet(BuildContext context, String message) {
    showModalBottomSheet<void>(
      context: context,
      barrierColor: const Color.fromRGBO(0, 0, 0, 0),
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 3), () {
          try {
            Navigator.pop(context);
          } on Exception {}
        });
        return Container(
            color: Colors.grey.shade800,
            padding: const EdgeInsets.all(12),
            child: Wrap(children: [
              Text(
                message,
                style: CustomTextStyles.white18,
              )
            ]));
      },
    );
  }
}
