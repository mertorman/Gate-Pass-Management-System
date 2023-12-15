import 'package:flutter/material.dart';
import 'package:gate_pass_management/feature/admin/view/admin_dashboard_view.dart';
import 'package:gate_pass_management/feature/auth/login-signup/controller/auth_controller.dart';
import 'package:gate_pass_management/feature/door-management/view/door_management_view.dart';
import 'package:gate_pass_management/feature/profile/view/profile_view.dart';
import 'package:gate_pass_management/feature/user/view/user_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../network/networkUtils.dart';
import '../../../product/constant/constants.dart';
import '../../auth/login-signup/models/user_Model.dart';

class MainWrapperController extends GetxController with StateMixin {
  late PageController pageController = PageController(initialPage: 0);
  NetworkUtils networkUtils = NetworkUtils();
  AuthController authController = Get.find();
  final box = GetStorage();
  RxInt currentPage = RxInt(0);

  @override
  void onInit() async {
    super.onInit();
    if (await box.read(GetStorageKeys.IS_LOGGED_IN) == true &&
        authController.newLogin == false) {
      change(null, status: RxStatus.loading());
      await getCurrentUser().then((value) {
        if (authController.userModel.value.user != null) {
          change(null, status: RxStatus.success());
        }
      });
    }else if(authController.newLogin == true){
      change(null, status: RxStatus.success());
    }
  }

  List<Widget> pagesAdmin = [
    const DoorManagementPage(),
    const AdminDashboard(),
    const ProfilePage()
  ];

  List<Widget> pagesUser = [const DoorManagementPage(), const UserPage(),const ProfilePage()];

  Future<void> getCurrentUser() async {
    try {
      authController.user = UserModel.fromJson(await networkUtils
          .handleResponse(await networkUtils.buildHttpResponse(
              APIEndPoints.authEndpoints.currentUser,
              method: HttpMethod.GET)));
    } catch (e) {
      print(e);
    }
  }

  void goToTab(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
