import 'package:flutter/material.dart';
import 'package:gate_pass_management/feature/auth/login-signup/models/user_Model.dart';
import 'package:gate_pass_management/product/constant/constants.dart';
import 'package:get/get.dart';
import 'package:gate_pass_management/network/NetworkUtils.dart';
import 'package:get_storage/get_storage.dart';

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
  

  Future<void> registerWithEmail() async {
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
      newLogin.value = true;
      var accessToken = userModel.value.tokens!.access!.token;
      var refreshToken = userModel.value.tokens!.refresh!.token;
      await box.write('accessToken', accessToken);
      await box.write('refreshToken', refreshToken);
      await box.write(GetStorageKeys.IS_LOGGED_IN, true);
      Get.offAllNamed("/mainwrapper");
    } catch (e) {
      print(e);
    }
  }

  Future<void> loginWithEmail() async {
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
      var accessToken = userModel.value.tokens!.access!.token;
      var refreshToken = userModel.value.tokens!.refresh!.token;
      newLogin.value = true;
      await box.write('accessToken', accessToken);
      await box.write('refreshToken', refreshToken);
      await box.write(GetStorageKeys.IS_LOGGED_IN, true);
      Get.offAllNamed("/mainwrapper");
    } catch (e) {
      print(e);
    }
  }
}
