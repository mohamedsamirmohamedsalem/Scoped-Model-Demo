import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

import '../../ui_helper/dialog_manager.dart';

class LocationManager {
  static const platform = MethodChannel('com.technoWays.joca');

  static Future<void> requestLocationPermission(BuildContext context) async {
    StreamSubscription<ServiceStatus> serviceStatusStream =
        Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
      debugPrint(status.toString());
      if (status == ServiceStatus.enabled) {
        checkPermission(context);
      } else {
        DialogsManager.showAlertWith2Action(
            context,
            "sorry".tr(),
            "Location service is not activated, do you want to activate it through settings"
                .tr(), onPressed: () async {
          Navigator.pop(context);
          print("backkkk");
          await Geolocator.openLocationSettings();
        });
      }
    });
  }

  static Future<LocationPermission> checkPermission(
      BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
    } else if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // Permissions are denied or denied forever, let's request it!
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
      } else if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        DialogsManager.showAlertWith2Action(
            context,
            "sorry".tr(),
            "You have denied the app from using your location. Please grant the app location permission through settings and try again"
                .tr(), onPressed: () async {
          Navigator.pop(context);
          await Geolocator.openLocationSettings();
          return Future.error(
              "Location permissions are permanently denied, we cannot request permissions"
                  .tr());
        });
      }
    }
    return permission;
  }

  static double calculateDistance(lat1, lon1, lat2, lon2) {
    double distanceInMeters =
        Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
    return distanceInMeters;
  }

  static Future<bool> isMockLocation() async {
    try {
      final bool result = await platform.invokeMethod('isMockLocation');
      return result;
    } on PlatformException catch (e) {
      print("Failed to check mock location: '${e.message}'.");
      return false;
    }
  }
}
