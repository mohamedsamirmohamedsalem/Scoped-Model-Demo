import 'package:scoped_model_demo/core/logic_helper/local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../import_all.dart';

class LanguageManager {
  static const _english = "en";
  static const _arabic = "ar";

  static final supportedLocalization = [
    const Locale(_english),
    const Locale(_arabic)
  ];

  static Future<Locale> getLanguage() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final postLocalDataSource = LocalDataSourceImpl(sharedPreferences);
    final cachedLangCode = await postLocalDataSource.getLanguageSetting();
    final bool? isEnglish = await postLocalDataSource.getLanguageSetting();
    final String languageCode = isEnglish == true ? _english : _arabic;
    final initialLocale = cachedLangCode != null
        ? Locale(languageCode, '')
        : const Locale(_english);
    return initialLocale;
  }
}
