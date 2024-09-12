import 'package:scoped_model_demo/scenes/authentication/sign_in/view_model/login_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/logic_helper/import_all.dart';
import '../core/logic_helper/local_data_source.dart';
import '../scenes/authentication/sign_in/service/login_service.dart';

GetIt locator = GetIt.instance;

class AppLocator {
  static void setupLocator() {
    _servicesLocator();
    _viewModelsLocator();
    _sharedPreferencesLocator();
  }

// Register services
  static void _servicesLocator() {
    locator.registerLazySingleton<LoginService>(() => LoginService());
  }

// Register ViewModels
  static void _viewModelsLocator() {
    locator.registerFactory<LoginViewModel>(() => LoginViewModel());
  }

// Register sharedPreferences
  static void _sharedPreferencesLocator() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    locator.registerLazySingleton<LocalDataSourceImpl>(
        () => LocalDataSourceImpl(sharedPreferences));
    locator.registerLazySingleton(() => sharedPreferences);
  }
}
