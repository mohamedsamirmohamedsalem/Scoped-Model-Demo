import 'dart:convert';

abstract class AppConstant {
  static String baseImageUrl = 'https://joca-api.technoapps.net/api/Images/';
  static String printPrettyJson<T>(T json) {
    return const JsonEncoder.withIndent('  ').convert(json);
  }
}
