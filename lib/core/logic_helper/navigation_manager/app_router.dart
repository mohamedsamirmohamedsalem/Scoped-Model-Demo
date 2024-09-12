import 'package:scoped_model_demo/scenes/authentication/sign_in/view/login_page.dart';

import '../import_all.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  bool isUserRegistered;

  AppRouter({required this.isUserRegistered});

  @override
  List<AutoRoute> get routes => [
        // AutoRoute(page: SplashRoute.page, initial: !isUserRegistered),
        // AutoRoute(page: NavigationContainerRoute.page, initial: isUserRegistered),
        AutoRoute(page: LoginRoute.page, initial: true),
      ];
}
