import 'package:flutter/material.dart';
import 'package:gate_pass_management/feature/admin/view/admin_dashboard_view.dart';
import 'package:gate_pass_management/feature/auth/login-signup/controller/auth_controller.dart';
import 'package:gate_pass_management/feature/door-management/view/door_management_view.dart';
import 'package:gate_pass_management/feature/user/view/user_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../network/networkUtils.dart';
import '../../../product/constant/constants.dart';
import '../../auth/login-signup/models/user_Model.dart';

class MainWrapperController extends GetxController with StateMixin {
  late PageController pageController;
  NetworkUtils networkUtils = NetworkUtils();
  AuthController authController = Get.find();
  final box = GetStorage();
  RxInt currentPage = RxInt(0);

  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.success());
    if (box.read(GetStorageKeys.IS_LOGGED_IN) == true && authController.newLogin.value == false) {
      change(null, status: RxStatus.loading());
      await getCurrentUser().then((value) {
        change(null, status: RxStatus.success());
        
      });
    }
    pageController = PageController(initialPage: 0);
  }

  List<Widget> pages = [
    const DoorManagementPage(),
    const AdminDashboard(),
    const UserPage()
  ];

  Future<void> getCurrentUser() async {
    try {
      authController.user = UserModel.fromJson(await networkUtils.handleResponse(
          await networkUtils.buildHttpResponse(
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
