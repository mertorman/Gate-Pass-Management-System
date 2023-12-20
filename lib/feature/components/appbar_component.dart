import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gate_pass_management/feature/main-wrapper/controller/main_wrapper_controller.dart';
import 'package:gate_pass_management/product/constant/constants.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  AppBarWidget({
    super.key,
  });
  MainWrapperController mainWrapperController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xffF9F9F9),
          statusBarIconBrightness: Brightness.dark),
      backgroundColor: Color(0xffF9F9F9),
      toolbarHeight: 65,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 24, top: 24),
        child: Obx(
          () => mainWrapperController.currentPage.value == 2
              ? Text("")
              : Text(
                  "ParkEasy",
                  style: GoogleFonts.robotoSlab(
                      textStyle: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 26,
                          fontWeight: FontWeight.bold)),
                ),
        ),
      ),
      centerTitle: mainWrapperController.currentPage.value == 2 ? true : null,
      title: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Obx(() => mainWrapperController.currentPage.value == 2
            ? Text(
                "Profile",
                style: GoogleFonts.robotoSlab(
                    textStyle: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 26,
                        fontWeight: FontWeight.bold)),
              )
            : Text("")),
      ),
      leadingWidth: 180,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 24, top: 24),
          child: InkWell(
            onTap: () {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.info,
                title: 'About ParkEasy',
                textColor: Colors.black,
                text:
                    'Developers:\n\nMert Orman => mertorman22@gmail.com\nEren Deveci => erendv@hotmail.com\n\nIt cannot be copied or changed without permission.\n\nParkEasy v1.0.0',
              );
            },
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              child: const Icon(
                Icons.question_mark,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
