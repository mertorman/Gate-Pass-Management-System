import 'package:flutter/material.dart';
import 'package:gate_pass_management/feature/components/appbar_component.dart';
import 'package:gate_pass_management/feature/main-wrapper/controller/main_wrapper_controller.dart';

import '../components/bottom_navigation_bar.dart';
import 'package:get/get.dart';

class MainWrapper extends StatelessWidget {
  MainWrapper({super.key});

  MainWrapperController mainWrapperController =
      Get.put(MainWrapperController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      bottomNavigationBar: NavigationBarBottom(),
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffF9F9F9),
      body: PageView(
        controller: mainWrapperController.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [...mainWrapperController.pages],
      ),
    );
  }
}
