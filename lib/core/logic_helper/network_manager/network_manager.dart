// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scoped_model_demo/core/constants/app-constant.dart';
import 'package:scoped_model_demo/core/logic_helper/import_all.dart';
import 'package:scoped_model_demo/core/logic_helper/localization_manager/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../local_data_source.dart';

part 'network_manager.freezed.dart';

@freezed
class NetworkResponse with _$NetworkResponse {
  const factory NetworkResponse.success(Map<String, dynamic> data) = Ok;
  const factory NetworkResponse.error(String message) = ERROR;
  const factory NetworkResponse.loading(String message) = LOADING;
}

class NetworkManager {
  final Dio dio = createDio();
  late Future<LocalDataSource> _localDataSourceFuture;

  NetworkManager._internal() {
    _localDataSourceFuture = _initializeLocalDataSource();
  }

  static final NetworkManager _singleton = NetworkManager._internal();

  factory NetworkManager() => _singleton;

  Future<LocalDataSource> _initializeLocalDataSource() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return LocalDataSourceImpl(sharedPreferences);
  }

  Future<void> _ensureInitialized() async {
    await _localDataSourceFuture;
  }

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: Endpoints.baseURL,
      receiveTimeout: const Duration(milliseconds: 20000), // 20 seconds
      connectTimeout: const Duration(milliseconds: 20000),
      sendTimeout: const Duration(milliseconds: 20000),
    ));

    dio.interceptors.addAll([
      // AuthInterceptor(dio),
      LoggingInterceptor(dio),
      ErrorInterceptors(dio),
    ]);

    return dio;
  }

  Future<NetworkResponse?> apiCall({
    required String url,
    required Map<String, dynamic>? queryParameters,
    required dynamic body,
    required RequestType requestType,
  }) async {
    await _ensureInitialized();
    final localDataSource = await _localDataSourceFuture;

    late Response result;
    try {
      // Get language and token
      final cachedUser = await localDataSource.getCachedUser();
      final token = cachedUser.token;
      final language = await localDataSource.getLanguageSetting() ?? true;
      final apiLanguageCode = language
          ? LanguageManager.apiEnglishCode
          : LanguageManager.apiArabicCode;

      Options options = Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "Accept-Language": apiLanguageCode,
        },
      );

      switch (requestType) {
        case RequestType.GET:
          result = await dio.get(url,
              queryParameters: queryParameters, options: options);
          break;
        case RequestType.POST:
          result = await dio.post(url, data: body, options: options);
          break;
        case RequestType.PUT:
          result = await dio.put(url, data: body, options: options);
          break;
        case RequestType.PATCH:
          result = await dio.patch(url, data: body, options: options);
          break;
        case RequestType.DELETE:
          result =
              await dio.delete(url, data: queryParameters, options: options);
          break;
      }

      debugPrint(
          "========================================================================================================");
      debugPrint(
          "========================================================================================================");
      debugPrint(
          "========================================================================================================");
      debugPrint("============= Response Started ==============");
      debugPrint("Request URL    : $url");
      debugPrint("Request Status Code    : ${result.statusCode.toString()}");
      debugPrint("Request Status Message : ${result.statusMessage}");
      debugPrint("Request Body : ${body.toString()}");
      debugPrint(
          "Request Data Model : ${AppConstant.printPrettyJson(result.data)}");
      debugPrint(
          "========================================================================================================");
      debugPrint(
          "========================================================================================================");
      debugPrint(
          "========================================================================================================");
      debugPrint(
          "========================================================================================================");

      if (result != null) {
        return NetworkResponse.success(result.data);
      } else {
        return const NetworkResponse.error("Data is null");
      }
    } on DioException catch (error) {
      return NetworkResponse.error(error.message ?? "Error");
    } catch (error) {
      return NetworkResponse.error(error.toString());
    }
  }

  Future<NetworkResponse?> apiCallWithFormData({
    required String url,
    required Map<String, dynamic>? queryParameters,
    required FormData body,
    required RequestType requestType,
  }) async {
    await _ensureInitialized();
    final localDataSource = await _localDataSourceFuture;

    try {
      // Get language and token
      final cachedUser = await localDataSource.getCachedUser();
      final token = cachedUser.token;
      final language = await localDataSource.getLanguageSetting();

      Options options = Options(
        headers: {
          "Authorization": "Bearer $token",
          'Content-Type': 'multipart/form-data',
          "Accept-Language": language ?? "en", // Default to English if not set
        },
      );

      late Response result;

      switch (requestType) {
        case RequestType.GET:
          result = await dio.get(url,
              queryParameters: queryParameters, options: options);
          break;
        case RequestType.POST:
          result = await dio.post(url, data: body, options: options);
          break;
        case RequestType.PUT:
          result = await dio.put(url, data: body, options: options);
          break;
        case RequestType.PATCH:
          result = await dio.patch(url, data: body, options: options);
          break;
        case RequestType.DELETE:
          result = await dio.delete(url,
              queryParameters: queryParameters, options: options);
          break;
      }

      debugPrint("=============================================");
      debugPrint("============= Response Started ==============");
      debugPrint("Request URL    : $url");
      debugPrint("Request Status Code    : ${result.statusCode.toString()}");
      debugPrint("Request Status Message : ${result.statusMessage}");
      debugPrint("Request Body : ${body.toString()}");
      debugPrint("Request Data Model : ${result.data.toString()}");
      debugPrint("============= Response Ended ==============");
      debugPrint("===========================================");

      if (result.statusCode != null &&
          (result.statusCode! >= 200 && result.statusCode! < 300)) {
        return NetworkResponse.success(result.data);
      } else {
        String errorMsg = result.data != null
            ? result.data.toString()
            : "Failed with status code: ${result.statusCode}";
        return NetworkResponse.error(errorMsg);
      }
    } on DioException catch (error) {
      debugPrint("DioException caught: ${error.response?.data}");
      return NetworkResponse.error(
          error.response?.data['message'] ?? error.message ?? "Error");
    } catch (error) {
      debugPrint("Exception caught: $error");
      return NetworkResponse.error(error.toString());
    }
  }
}

// class AuthInterceptor extends Interceptor {
//   final Dio dio;
//
//   AuthInterceptor(this.dio);
//
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
//     var accessToken = await TokenRepository().getAccessToken();
//
//     if (accessToken != null) {
//       var expiration = await TokenRepository().getAccessTokenRemainingTime();
//
//       if (expiration.inSeconds < 60) {
//         // Call the refresh endpoint to get a new token
//         try {
//           var response = await UserService().refresh();
//           await TokenRepository().persistAccessToken(response.accessToken);
//           accessToken = response.accessToken;
//         } catch (error) {
//           handler.reject(DioException(requestOptions: options, error: error));
//           return;
//         }
//       }
//
//       options.headers['Authorization'] = 'Bearer $accessToken';
//     }
//
//     handler.next(options);
//   }
// }

class ErrorInterceptors extends Interceptor {
  final Dio dio;

  ErrorInterceptors(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw TimeOutException(err.requestOptions);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          case 401:
            throw UnauthorizedException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
        throw NoInternetConnectionException(err.requestOptions);
      case DioExceptionType.connectionError:
        throw ConnectionErrorException(err.requestOptions);
      case DioExceptionType.badCertificate:
        throw BadCertificateException(err.requestOptions);
    }

    return handler.next(err);
  }
}

class ConnectionErrorException extends DioException {
  ConnectionErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Connection error, please check your network connection.';
  }
}

class BadCertificateException extends DioException {
  BadCertificateException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Bad certificate error, the SSL certificate is not valid.';
  }
}

class BadRequestException extends DioException {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioException {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioException {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class TimeOutException extends DioException {
  TimeOutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}

class LoggingInterceptor extends Interceptor {
  final Dio dio;

  LoggingInterceptor(this.dio);

  static const String green = '\x1B[32m';
  static const String blue = '\x1B[34m';
  static const String reset = '\x1B[0m';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    printCurl(options);
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        '${blue}RESPONSE[${response.statusCode}] => DATA: ${response.data.toString()}$reset');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
        'ERROR[${err.response?.statusCode}] => ERROR: ${err.message.toString()}');
    return super.onError(err, handler);
  }

  void printCurl(RequestOptions options) {
    final method = options.method;
    final headers = options.headers;
    final data = options.data;
    final queryParameters = options.queryParameters;
    final url = options.uri.toString();

    final curl = StringBuffer('curl -X $method \'$url\'');

    headers.forEach((k, v) {
      curl.write(' -H "$k: $v"');
    });

    if (queryParameters.isNotEmpty) {
      curl.write(' -G');
      queryParameters.forEach((k, v) {
        curl.write(' -d "$k=$v"');
      });
    }

    if (data != null) {
      if (data is Map) {
        final jsonData = jsonEncode(data);
        curl.write(' -d \'$jsonData\'');
      } else {
        curl.write(' -d "$data"');
      }
    }

    print('${green}CURL: $curl$reset');
  }
}
