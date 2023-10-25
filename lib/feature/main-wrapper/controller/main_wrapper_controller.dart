import 'package:flutter/material.dart';
import 'package:gate_pass_management/feature/admin/view/admin_dashboard_view.dart';
import 'package:gate_pass_management/feature/door-management/view/door_management_view.dart';
import 'package:gate_pass_management/feature/user/view/user_view.dart';
import 'package:get/get.dart';

class MainWrapperController extends GetxController {
  late PageController pageController;

  RxInt currentPage = RxInt(0);

  List<Widget> pages = [
    const DoorManagementPage(),
    const AdminDashboard(),
    const UserPage()
  ];

  void goToTab(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
