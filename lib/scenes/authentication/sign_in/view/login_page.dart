// ignore_for_file: camel_case_types
import 'package:easy_localization/easy_localization.dart';
import 'package:scoped_model_demo/core/logic_helper/import_all.dart';
import 'package:scoped_model_demo/core/ui_helper/shared_component/custom_button.dart';
import 'package:scoped_model_demo/core/ui_helper/shared_component/custom_edit_text.dart';
import 'package:scoped_model_demo/scenes/authentication/sign_in/view_model/login_view_model.dart';

@RoutePage()
class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  late LoginViewModel viewModel;
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(builder: (context, child, loginViewModel) {
      viewModel = loginViewModel;
      return EasyLoading(
        show: viewModel.state == ViewState.Loading,
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: const CustomAppBar(),
          body: SingleChildScrollView(
            child: Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: SizeConfig.screenHeight * 0.13),
                      Text(
                        "sign_in".tr(),
                        style: CustomTextStyles.blackBold32,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        hintText: 'email'.tr(),
                        controller: emailController,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        hintText: 'password'.tr(),
                        obscureText: true,
                        controller: passwordController,
                      ),
                      const SizedBox(height: 5),
                      buildForgetPasswordView(),
                      buildSignINButtonView(),
                      const SizedBox(height: 20),
                      buildSocialMediaView(),
                      const SizedBox(height: 20),
                    ],
                  ),
                  buildCreateAccountButton(),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget buildForgetPasswordView() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        children: [
          Checkbox(
            checkColor: Colors.white,
            fillColor: WidgetStateProperty.all<Color?>(
                viewModel.isChecked ? Colors.green : Colors.white),
            value: viewModel.isChecked,
            shape: const CircleBorder(),
            onChanged: (bool? value) {
              setState(() {
                viewModel.updateCheckBox(value ?? false);
              });
            },
          ),
          Text("remember_me".tr(), style: CustomTextStyles.semiBlack12)
        ],
      ),
      GestureDetector(onTap: () {}, child: Text("forgot_password".tr()))
    ]);
  }

  Widget buildSignINButtonView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: SizeConfig.infinityWidth,
          child: CustomDarkButton(
              text: "sign_in".tr(),
              onPressed: () async {
                if (emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  viewModel.phone = emailController.text.toString();
                  await viewModel.applyLogin(
                      context: context,
                      emailOrMobileNumber: emailController.text,
                      password: passwordController.text);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("enter_username_password".tr())),
                  );
                }
              }),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(height: 1, width: 100, color: Colors.black45),
            Text(
              "or_sign_in_with".tr(),
              style: CustomTextStyles.black14,
            ),
            Container(height: 1, width: 100, color: Colors.black45),
          ],
        ),
      ],
    );
  }

  Widget buildSocialMediaView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CustomImageButton(
          image: ImageConstant.facebook,
          backgroundColor: appTheme.facebookColorBlue,
          onPressed: () {},
        ),
        CustomImageButton(
          image: ImageConstant.google,
          backgroundColor: Colors.white,
          onPressed: () {},
        ),
        CustomImageButton(
          image: ImageConstant.apple,
          backgroundColor: Colors.white,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget buildCreateAccountButton() {
    return SizedBox(
      width: SizeConfig.infinityWidth,
      child: CustomTransparentButton(
          text: "create_free_account".tr(),
          foregroundColor: AppColors.semiBlackBlueColor,
          backgroundColor: Colors.white,
          onPressed: () {}),
    );
  }
}
