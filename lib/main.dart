import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model_demo/core/logic_helper/authentication_manager/authentication_manager.dart';
import 'package:scoped_model_demo/core/logic_helper/import_all.dart';

import 'core/constants/app-constant.dart';
import 'core/logic_helper/localization_manager/language_manager.dart';
import 'core/logic_helper/provider_manager/provider_manager.dart';

bool isUserRegistered = false;
Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  AppLocator.setupLocator();
  isUserRegistered = await AuthenticationManager.checkIfUserAlreadyRegistered();

  Future.wait([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  ]).then((value) async {
    runApp(
      EasyLocalization(
        saveLocale: true,
        path: AppConstant.translationsPath,
        startLocale: await LanguageManager.getLanguage(),
        fallbackLocale: LanguageManager.localEnglish,
        supportedLocales: LanguageManager.supportedLocalization,
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
    return MultiProvider(
      providers: ProviderManager.providersList,
      child: MaterialApp.router(
        title: AppConstant.appName,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
