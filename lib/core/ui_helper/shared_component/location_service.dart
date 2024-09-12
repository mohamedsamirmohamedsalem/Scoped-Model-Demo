import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Future<Position?> getCurrentLocation() async {
    // Request location permission
    final permissionStatus = await Permission.location.request();

    if (permissionStatus.isGranted) {
      // Check if location service is enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }

      // Get current location
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } else {
      return Future.error('Location permission denied.');
    }
  }
}
