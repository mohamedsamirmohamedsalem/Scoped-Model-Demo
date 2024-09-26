import 'dart:convert';

abstract class AppConstant {
  static String appName = 'Scoped Model Demo';
  static String translationsPath = 'assets/translations';
  static String baseImageUrl = 'https://joca-api.technoapps.net/api/Images/';

  static String printPrettyJson<T>(T json) {
    return const JsonEncoder.withIndent('  ').convert(json);
  }
}
