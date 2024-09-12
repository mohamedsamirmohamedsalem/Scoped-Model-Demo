// ignore_for_file: use_build_context_synchronously

import 'package:geolocator/geolocator.dart';
import 'package:scoped_model_demo/core/logic_helper/import_all.dart';
import 'package:scoped_model_demo/core/logic_helper/local_data_source.dart';
import 'package:scoped_model_demo/scenes/authentication/sign_in/model/login_model.dart';
import 'package:scoped_model_demo/scenes/authentication/sign_in/service/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends BaseViewModel {
  bool isChecked = false;
  late BuildContext _context;
  late LoginModel? _loginModel;
  late Position? currentLocation;
  final LoginService _service = locator<LoginService>();
  String phone = "";
  late SharedPreferences sharedPreferences;
  late LocalDataSourceImpl postLocalDataSource;

  Future applyLogin({
    required BuildContext context,
    required String emailOrMobileNumber,
    required String password,
  }) async {
    try {
      _context = context;
      setState(ViewState.Loading);
      final response = await _service.login(emailOrMobileNumber, password);
      setState(ViewState.Retrieved);
      _loginModel = response.data as LoginModel?;

      if (response.isSuccess) {
        await cacheUserData();
      } else {
        setState(ViewState.Error);
        showError(response.message);
      }
    } catch (e) {
      setState(ViewState.Error);
      showError('$e');
    }
  }

  Future<void> cacheUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    LocalDataSourceImpl postLocalDataSource =
        LocalDataSourceImpl(sharedPreferences);

    await postLocalDataSource.setUserLoginResponse(_loginModel);
    await postLocalDataSource.setRememberUser(isChecked);
  }

  void showError(String errorMessage) {
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  }

  void updateCheckBox(bool newVal) {
    isChecked = newVal;
    updateView();
  }
}
