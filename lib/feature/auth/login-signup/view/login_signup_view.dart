import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gate_pass_management/feature/auth/login-signup/components/loginWidget.dart';
import 'package:gate_pass_management/feature/auth/login-signup/components/signupWidget.dart';
import 'package:gate_pass_management/feature/auth/login-signup/controller/auth_controller.dart';
import 'package:gate_pass_management/product/constant/constants.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
//import 'package:rive/rive.dart' as rv;
import 'package:kartal/kartal.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final PageController pageController = PageController(initialPage: 0);
 // AuthController authController = Get.put(AuthController(),permanent: true);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [Color(0XFF8BC6EC), Color(0XFF9599E2)])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              scrolledUnderElevation: 0,
              elevation: 0,
              centerTitle: true,
              title: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Park",
                    style: GoogleFonts.poppins(
                        fontSize: 25, fontWeight: FontWeight.bold)),
                TextSpan(
                    text: "Easy",
                    style: GoogleFonts.poppins(
                        fontSize: 25,
                        color: AppColors.primaryColor.withOpacity(0.9),
                        fontWeight: FontWeight.bold))
              ]))),
          // backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              //rv.RiveAnimation.asset("assets/riveassets/shapes.riv"),
              Positioned.fill(
                  child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
                child: SizedBox(),
              )),
              SingleChildScrollView(
                child: SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        30.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              height: context.general.isKeyBoardOpen
                                  ? MediaQuery.of(context).size.height * 0.15
                                  : MediaQuery.of(context).size.height * 0.15,
                            
                              child: Image.asset(
                                AppImages.loginImage,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.38,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AnimatedDefaultTextStyle(
                                      duration: Duration(milliseconds: 300),
                                      style: GoogleFonts.poppins(
                                          fontSize:
                                              context.general.isKeyBoardOpen
                                                  ? 22
                                                  : 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      child: Text(
                                        "Welcome\nParkEasy",
                                      ),
                                    ),
                                    10.height,
                                    Text(
                                      "Log in to the ParkEasy parking management system.",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                          height: 1.5,
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        30.height,
                        SizedBox(
                          height: 470,
                          child: Column(
                            children: [
                              Expanded(
                                child: PageView(
                                  controller: pageController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    LoginWidget(
                                      pageController: pageController,
                                    ),
                                    SignUpWidget(
                                      pageController: pageController,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              ),
            ],
          )),
    );
  }
}
