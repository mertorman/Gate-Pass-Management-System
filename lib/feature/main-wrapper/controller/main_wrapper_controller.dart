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
  late PageController pageController=PageController(initialPage: 0);
  NetworkUtils networkUtils = NetworkUtils();
  AuthController authController = Get.find();
  final box = GetStorage();
  RxInt currentPage = RxInt(0);

  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.loading());
    if (await box.read(GetStorageKeys.IS_LOGGED_IN) == true && authController.newLogin.value == false) {
      change(null, status: RxStatus.loading());
      await getCurrentUser().then((value) {
        change(null, status: RxStatus.success());
        
      });
    }
 
  }

  List<Widget> pagesAdmin = [
    const DoorManagementPage(),
    const AdminDashboard(),
    const UserPage()
  ];

    List<Widget> pagesUser = [
    const DoorManagementPage(),
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
