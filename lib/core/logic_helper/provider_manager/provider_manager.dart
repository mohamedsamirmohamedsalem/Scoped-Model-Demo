import 'package:provider/single_child_widget.dart';

abstract class ProviderManager {
  static List<SingleChildWidget> providersList = [
    // ChangeNotifierProvider(create: (context) => NotificationProvider()),
  ];
}
