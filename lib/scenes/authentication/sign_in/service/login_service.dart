import 'package:scoped_model_demo/core/logic_helper/network_manager/generic_response.dart';
import 'package:scoped_model_demo/scenes/authentication/sign_in/model/login_model.dart';

import '../../../../core/logic_helper/import_all.dart';

class LoginService {
  final NetworkManager _networkManager = NetworkManager();

  Future<GenericResponse> login(
      String emailOrMobileNumber, String password) async {
    late var genericResponse;
    try {
      final body = {
        'data': {
          'emailOrMobileNumber': emailOrMobileNumber,
          'password': password
        }
      };

      NetworkResponse? networkResponse = await _networkManager.apiCall(
        url: Endpoints.login,
        queryParameters: {},
        body: body,
        requestType: RequestType.POST,
      );

      networkResponse?.maybeWhen(success: (responseData) {
        genericResponse = GenericResponse<LoginModel>.fromJson(
            responseData, (data) => LoginModel.fromJson(data));
      }, loading: (message) {
        debugPrint(message);
      }, error: (message) {
        debugPrint(message);
      }, orElse: () {
        debugPrint("error");
      });

      return genericResponse;
    } catch (e) {
      rethrow;
    }
  }
}
