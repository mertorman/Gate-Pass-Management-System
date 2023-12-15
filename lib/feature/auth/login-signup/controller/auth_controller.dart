import 'package:flutter/material.dart';
import 'package:gate_pass_management/feature/auth/login-signup/models/user_Model.dart';
import 'package:gate_pass_management/product/constant/constants.dart';
import 'package:get/get.dart';
import 'package:gate_pass_management/network/NetworkUtils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:quickalert/quickalert.dart';
import '../../../components/snackbar_content.dart';

class AuthController extends GetxController {
  final box = GetStorage();
  NetworkUtils networkUtils = NetworkUtils();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool newLogin = RxBool(false);
  Rx<UserModel> userModel = UserModel().obs;
  set user(UserModel value) => userModel.value = value;

  Future<void> registerWithEmail(BuildContext context) async {
    try {
      Map body = {
        "email": emailController.text,
        "password": passwordController.text,
        "username": nameController.text,
        "phone": phoneController.text
      };
      user = UserModel.fromJson(await networkUtils.handleResponse(
          await networkUtils.buildHttpResponse(
              APIEndPoints.authEndpoints.registerEmail,
              request: body,
              method: HttpMethod.POST)));
      if (userModel.value.user?.isApproved == true &&
          userModel.value.user != null) {
        newLogin.value = true;
        var accessToken = userModel.value.tokens!.access!.token;
        var refreshToken = userModel.value.tokens!.refresh!.token;
        await box.write('accessToken', accessToken);
        await box.write('refreshToken', refreshToken);
        await box.write(GetStorageKeys.IS_LOGGED_IN, true);
        Get.offAllNamed("/mainwrapper");
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Successful!',
          text:
              'The registration process is successful, you will be able to log in to the application after your account is approved by our administrators.',
        );
        nameController.clear();
        emailController.clear();
        phoneController.clear();
        passwordController.clear();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> loginWithEmail(BuildContext context) async {
    try {
      Map body = {
        "email": emailController.text,
        "password": passwordController.text,
      };
      user = UserModel.fromJson(await networkUtils.handleResponse(
          await networkUtils.buildHttpResponse(
              APIEndPoints.authEndpoints.loginEmail,
              request: body,
              method: HttpMethod.POST)));
      if (userModel.value.user?.isApproved == true &&
          userModel.value.user != null) {
        var accessToken = userModel.value.tokens!.access!.token;
        var refreshToken = userModel.value.tokens!.refresh!.token;
        newLogin.value = true;
        await box.write('accessToken', accessToken);
        await box.write('refreshToken', refreshToken);
        await box.write(GetStorageKeys.IS_LOGGED_IN, true);
        Get.offAllNamed("/mainwrapper");
      } else {
        final snackBar = SnackbarContent(
            "Hesap Onayı",
            "Hesabınız onay aşamasındadır. Onaylandıktan sonra giriş yapabileceksiniz.",
            ContentType.warning);

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    try {
      await box.erase();
      newLogin.value = false;
      Get.offAllNamed("/login");
    } catch (e) {
      print(e);
    }
  }
}
