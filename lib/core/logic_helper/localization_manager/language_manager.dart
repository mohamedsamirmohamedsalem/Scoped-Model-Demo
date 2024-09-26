import 'package:devicelocale/devicelocale.dart';
import 'package:scoped_model_demo/core/logic_helper/local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../import_all.dart';

class LanguageManager {
  static const _english = "en";
  static const _arabic = "ar";

  static Locale localEnglish = const Locale(_english);
  static Locale localArabic = const Locale(_arabic);

  static String apiEnglishCode = "en-US";
  static String apiArabicCode = "ar-SA";

  static final supportedLocalization = [localEnglish, localArabic];

  static Future<Locale> getLanguage() async {
    String initialLanguageCode = _english;
    final sharedPreferences = await SharedPreferences.getInstance();
    final postLocalDataSource = LocalDataSourceImpl(sharedPreferences);
    final bool? cachedLangCode = await postLocalDataSource.getLanguageSetting();

    // Get the device's locale
    final deviceLocale = await Devicelocale.defaultLocale ?? _english;
    // Check if the user has already selected a language or set the device's locale
    if (cachedLangCode == null) {
      // If no cached language, use the device's locale
      initialLanguageCode = deviceLocale.split('-').first;
      bool isEnglish = initialLanguageCode == _english ? true : false;
      postLocalDataSource.setLanguageSetting(isEnglish);
    } else {
      initialLanguageCode = cachedLangCode ? _english : _arabic;
    }
    // Set the initial locale for the app
    Locale initialLocale = Locale(initialLanguageCode);
    return initialLocale;
  }
}
