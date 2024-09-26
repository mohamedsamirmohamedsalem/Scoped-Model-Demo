import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../import_all.dart';

abstract class ProviderManager {
  static List<SingleChildWidget> providersList = [
    ChangeNotifierProvider(create: (context) => NotificationProvider()),
  ];
}

class NotificationProvider extends ChangeNotifier {
  int notificationCount;
  NotificationProvider({this.notificationCount = 0});

  void getNotificationCount(BuildContext context) async {
    notificationCount = 100000;
    notifyListeners();
  }
}
