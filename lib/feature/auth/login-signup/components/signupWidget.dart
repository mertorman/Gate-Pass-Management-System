import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controller/auth_controller.dart';

// ignore: must_be_immutable
class SignUpWidget extends StatelessWidget {
  SignUpWidget({super.key, required this.pageController});
  PageController pageController;
  AuthController authController = Get.find();
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  10.width,
                  const Icon(Icons.person),
                  20.width,
                  Expanded(
                      child: TextField(
                    controller: authController.nameController,
                    decoration: InputDecoration(
                        hintText: "Enter Full Name", border: InputBorder.none),
                    style: GoogleFonts.poppins(fontSize: 16),
                  ))
                ],
              ),
            ),
          ),
          25.height,
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  10.width,
                  const Icon(Icons.mail_lock_outlined),
                  20.width,
                  Expanded(
                      child: TextField(
                    controller: authController.emailController,
                    decoration: InputDecoration(
                        hintText: "Enter email", border: InputBorder.none),
                    style: GoogleFonts.poppins(fontSize: 16),
                  ))
                ],
              ),
            ),
          ),
          25.height,
           Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  10.width,
                  const Icon(Icons.phone),
                  20.width,
                  Expanded(
                      child: TextField(
                        controller: authController.phoneController,
                    decoration: InputDecoration(
                        hintText: "Enter phone number", border: InputBorder.none),
                    style: GoogleFonts.poppins(fontSize: 16),
                  ))
                ],
              ),
            ),
          ),
          25.height,
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  10.width,
                  const Icon(Icons.lock_outline),
                  20.width,
                  Expanded(
                      child: TextField(
                    obscureText: true,
                    controller: authController.passwordController,
                    decoration: InputDecoration(
                        hintText: "Enter password", border: InputBorder.none),
                    style: GoogleFonts.poppins(fontSize: 16),
                  ))
                ],
              ),
            ),
          ),
          24.height,
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  10.width,
                  const Icon(Icons.lock_outline),
                  20.width,
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                        hintText: "Confirm password", border: InputBorder.none),
                    style: GoogleFonts.poppins(fontSize: 16),
                  ))
                ],
              ),
            ),
          ),
          24.height,
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  maximumSize: Size(MediaQuery.of(context).size.width * 0.8,
                      MediaQuery.of(context).size.height * 0.07),
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.5,
                      MediaQuery.of(context).size.height * 0.07),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              onPressed: () async {
                await authController.registerWithEmail();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text("Sign Up"), 8.width, Icon(Icons.arrow_forward)],
              )),
          8.height,
          TextButton(
              onPressed: () {
                pageController.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  Text(
                    "Login Page",
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
