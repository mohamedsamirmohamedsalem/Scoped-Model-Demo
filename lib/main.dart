import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:scoped_model_demo/core/logic_helper/authentication_manager/authentication_manager.dart';
import 'package:scoped_model_demo/core/logic_helper/import_all.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/logic_helper/local_data_source.dart';

bool isUserRegistered = false;
Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  AppLocator.setupLocator();
  final sharedPreferences = await SharedPreferences.getInstance();
  final postLocalDataSource = LocalDataSourceImpl(sharedPreferences);
  final cachedLangCode = await postLocalDataSource.getLanguageSetting();
  final bool? isEnglish = await postLocalDataSource.getLanguageSetting();
  final String languageCode = isEnglish == true ? 'ar' : 'en';
  final initialLocale =
      cachedLangCode != null ? Locale(languageCode, '') : const Locale('en');
  isUserRegistered = await AuthenticationManager.checkIfUserAlreadyRegistered();
  Future.wait([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  ]).then((value) {
    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        fallbackLocale: const Locale('en'),
        startLocale: initialLocale,
        // Set the initial app language
        saveLocale: true,
        path: 'assets/translations',
        child: MyApp(),
      ),
    );
  });
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter(isUserRegistered: isUserRegistered);
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return
    //   MultiProvider(
    // providers: ProviderManager.providersList,
    // child:
    return MaterialApp.router(
      title: "Demooo",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: _appRouter.config(),
      // ),
    );
  }
}
