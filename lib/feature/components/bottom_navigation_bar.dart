import 'package:flutter/material.dart';
import 'package:gate_pass_management/feature/main-wrapper/controller/main_wrapper_controller.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavigationBarBottom extends StatelessWidget {
  NavigationBarBottom({
    super.key,
  });
  MainWrapperController mainWrapperController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child:GNav(
            backgroundColor: Colors.white,
            color: Colors.grey,
            activeColor: Colors.grey,
            padding: EdgeInsets.all(12),
            gap: 8,
            tabs: [
              GButton(
                onPressed: () => mainWrapperController.goToTab(0),
                icon: Icons.home,
                iconActiveColor: Color(0xFF8186dd),
                iconSize: 27,
              ),
              GButton(
                  onPressed: () => mainWrapperController.goToTab(1),
                  icon: Icons.settings,
                  iconActiveColor: Color(0xFF8186dd),
                  iconSize: 27),
              GButton(
                 onPressed: () => mainWrapperController.goToTab(2),
                  icon: Icons.home,
                  iconActiveColor: Color(0xFF8186dd),
                  iconSize: 27),
              GButton(
                  icon: Icons.person,
                  iconActiveColor: Color(0xFF8186dd),
                  iconSize: 27)
            ],
          ),
      
      ),
    );
  }
}
