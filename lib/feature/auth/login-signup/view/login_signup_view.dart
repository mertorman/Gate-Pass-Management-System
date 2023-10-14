import 'package:flutter/material.dart';
import 'package:gate_pass_management/feature/auth/login-signup/components/loginWidget.dart';
import 'package:gate_pass_management/feature/auth/login-signup/components/signupWidget.dart';
import 'package:gate_pass_management/product/constant/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [Color(0XFF8BC6EC), Color(0XFF9599E2)])),
      child: Scaffold(
          appBar: AppBar(
              scrolledUnderElevation: 0,
              elevation: 0,
              backgroundColor: Colors.transparent,
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
                        color: Color(0xFF8186dd),
                        fontWeight: FontWeight.bold))
              ]))),
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          AppImages.loginImage,
                          height: context.height() * 0.3,
                          width: context.width() * 0.55,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            width: context.width() * 0.38,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Welcome\nBack",
                                  style: GoogleFonts.poppins(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
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
                      height: 490,
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
                                SignUpWidget(pageController: pageController,)
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
          )),
    );
  }
}



