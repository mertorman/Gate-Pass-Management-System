import 'package:flutter/material.dart';
import 'package:gate_pass_management/product/constant/constants.dart';
import 'package:get/get.dart' hide ContextExtensionss;
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../auth/login-signup/controller/auth_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final box = GetStorage();
  AuthController authController = Get.find();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    Future.delayed(const Duration(seconds: 2)).then((value) {
    if (box.read(GetStorageKeys.IS_LOGGED_IN) == true) {
      Get.offAllNamed('/mainwrapper');
    } else {
      Get.offAllNamed('/login');
    }
    });
  
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: LinearGradient(
       begin: Alignment.topCenter, colors: [Color(0XFF8BC6EC), Color(0XFF9599E2)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: context.height(),
          width: context.width(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Park",
                        style: GoogleFonts.poppins(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: "Easy",
                        style: GoogleFonts.poppins(
                            fontSize: 30,
                            color: AppColors.primaryColor.withOpacity(0.9),
                            fontWeight: FontWeight.bold))
                  ])),
              ],
            ),
          ),
        ).center(),
      ),
    );
  }
}
