import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gate_pass_management/product/constant/constants.dart';
import 'package:google_fonts/google_fonts.dart';


class AppBarWidget extends StatelessWidget implements PreferredSizeWidget{
  const AppBarWidget({
    super.key,
  });

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
        child: Text(
          "ParkEasy",
          style: GoogleFonts.robotoSlab(
              textStyle: const TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold)),
        ),
      ),
      leadingWidth: 180,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 24, top: 24),
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: const Icon(
              Icons.notifications_none,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
   @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

