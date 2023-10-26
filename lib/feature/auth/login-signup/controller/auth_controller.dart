import 'package:flutter/material.dart';
import 'package:gate_pass_management/feature/auth/login-signup/models/user_Model.dart';
import 'package:gate_pass_management/product/constant/constants.dart';
import 'package:get/get.dart';
import 'package:gate_pass_management/network/NetworkUtils.dart';

class AuthController extends GetxController {
  NetworkUtils networkUtils = NetworkUtils();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Rx<UserModel> userModel = UserModel().obs;
  set user(UserModel value) => userModel.value = value;
  

  Future<void> registerWithEmail() async {
    try {
      Map body = {
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text
      };
      user = UserModel.fromJson(await networkUtils.handleResponse(
          await networkUtils.buildHttpResponse(
              APIEndPoints.authEndpoints.registerEmail,
              request: body,
              method: HttpMethod.POST)));
      Get.toNamed("/mainwrapper");
    } catch (e) {
      print(e);
    }
  }



}
