import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:scoped_model_demo/core/logic_helper/local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../import_all.dart';

// Mark: how to use biometrics
// void authenticateUser() async {
//   await authenticationManager.isDeviceSupported();
//   await authenticationManager.checkBiometrics();
//   await authenticationManager.getAvailableBiometrics();
//   final bool isAuthenticated =
//   await authenticationManager.authenticateBiometrics();
//   if (isAuthenticated) {
//    apply login
//   }
// }

enum SupportState {
  unKnown,
  supported,
  unSupported,
}

class AuthenticationManager {
  static String _authorized = 'Not Authorized';
  static late SharedPreferences sharedPreferences;
  static late LocalDataSourceImpl postLocalDataSource;
  static final LocalAuthentication auth = LocalAuthentication();
  static late List<BiometricType>? availableBiometrics;

  static Future<bool> checkIfUserAlreadyRegistered() async {
    sharedPreferences = await SharedPreferences.getInstance();
    postLocalDataSource = LocalDataSourceImpl(sharedPreferences);

    final bool isUserCached =
        await postLocalDataSource.getRememberUser() ?? false;
    final bool needToLogin = await _checkIfNeedToLogin();

    if (needToLogin || (isUserCached == false)) {
      return false;
    } else {
      return true;
    }
  }

  static Future<bool> _checkIfNeedToLogin() async {
    postLocalDataSource.getCachedUser().then((loginModel) {
      // Check if the access token is available
      if (loginModel.token == null) {
        return true;
      }
    });
    // call here the refresh token endpoint
    return false;
  }

  Future<SupportState> isDeviceSupported() async {
    SupportState supportState = SupportState.unKnown;
    await auth.isDeviceSupported().then((isSupported) => {
          supportState =
              isSupported ? SupportState.supported : SupportState.unSupported
        });
    return supportState;
  }

  static Future<bool> checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      debugPrint(e.toString());
    }
    return canCheckBiometrics;
  }

  static Future<List<BiometricType>> getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      debugPrint(e.toString());
    }
    return availableBiometrics;
  }

  static Future<bool> authenticateBiometrics() async {
    bool authenticated = false;
    try {
      _authorized = 'Authenticating';
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options:
            const AuthenticationOptions(stickyAuth: true, biometricOnly: true),
      );
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      _authorized = 'Error - ${e.message}';
      return false;
    }
    _authorized = authenticated ? 'Authorized' : 'Not Authorized';
    return authenticated;
  }
}
