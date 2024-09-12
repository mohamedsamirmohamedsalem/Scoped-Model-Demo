import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:scoped_model_demo/scenes/authentication/sign_in/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<Unit> setUserLoginResponse(
      LoginModel? userLoginModel); // Adjust the return type
  Future<LoginModel> getCachedUser();
  Future<Unit> clearUserCache();
  Future<bool> setRememberUser(bool remember);
  Future<bool?> getRememberUser();
  Future<Unit> setLanguageSetting(bool isEnglish);
  Future<bool?> getLanguageSetting();
  Future<Unit> setLocationSetting(bool isEnabled);
  Future<bool?> getLocationSetting();
  Future<Unit> setCameraSetting(bool isEnabled);
  Future<bool?> getCameraSetting();
  Future<int> setNotificationCount(int notificationCount);
  Future<int> getNotificationCount();
}

const CACHED_USER_LOGIN_RESPONSE = "CACHED_USER_LOGIN_RESPONSE";
const REMEMBER_USER = "REMEMBER_USER";
const LANGUAGE_SETTINGS = "LANGUAGE_SETTINGS";
const LOCATION_SETTINGS = "LOCATION_SETTINGS";
const CAMERA_SETTINGS = "CAMERA_SETTINGS";
const NOTIFICATION_COUNT = "NOTIFICATION_COUNT";

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<Unit> setUserLoginResponse(LoginModel? userLoginModel) async {
    final userJson = json.encode(userLoginModel?.toJson());
    await sharedPreferences.setString(CACHED_USER_LOGIN_RESPONSE, userJson);
    return unit;
  }

  @override
  Future<Unit> setLanguageSetting(bool isEnglish) async {
    await sharedPreferences.setBool(LANGUAGE_SETTINGS, isEnglish);
    return unit;
  }

  @override
  Future<Unit> setLocationSetting(bool isEnabled) async {
    await sharedPreferences.setBool(LOCATION_SETTINGS, isEnabled);
    return unit;
  }

  @override
  Future<Unit> setCameraSetting(bool isEnabled) async {
    await sharedPreferences.setBool(CAMERA_SETTINGS, isEnabled);
    return unit;
  }

  @override
  Future<LoginModel> getCachedUser() async {
    final userJson = sharedPreferences.getString(CACHED_USER_LOGIN_RESPONSE);
    if (userJson != null) {
      final userMap = json.decode(userJson);
      return LoginModel.fromJson(userMap);
    } else {
      return LoginModel();
    }
  }

  @override
  Future<Unit> clearUserCache() async {
    await sharedPreferences.remove(CACHED_USER_LOGIN_RESPONSE);
    return unit;
  }

  @override
  Future<bool> setRememberUser(bool remember) async {
    await sharedPreferences.setBool(REMEMBER_USER, remember);
    return remember;
  }

  @override
  Future<int> setNotificationCount(int notificationCount) async {
    await sharedPreferences.setInt(NOTIFICATION_COUNT, notificationCount);
    return notificationCount;
  }

  @override
  Future<bool?> getRememberUser() async {
    return sharedPreferences.getBool(REMEMBER_USER);
  }

  @override
  Future<bool?> getLanguageSetting() async {
    return sharedPreferences.getBool(LANGUAGE_SETTINGS);
  }

  @override
  Future<bool?> getLocationSetting() async {
    return sharedPreferences.getBool(LOCATION_SETTINGS);
  }

  @override
  Future<bool?> getCameraSetting() async {
    return sharedPreferences.getBool(CAMERA_SETTINGS);
  }

  @override
  Future<int> getNotificationCount() async {
    return sharedPreferences.getInt(NOTIFICATION_COUNT) ?? 0;
  }
}
