import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:gate_pass_management/feature/auth/login-signup/controller/auth_controller.dart';
import 'package:gate_pass_management/feature/components/appbar_component.dart';
import 'package:gate_pass_management/product/constant/constants.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

AuthController authController = Get.find();
TextEditingController usernameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneController = TextEditingController();

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    usernameController.text =
        authController.userModel.value.user!.username.toString();
    emailController.text =
        authController.userModel.value.user!.email.toString();
    phoneController.text =
        authController.userModel.value.user!.phone.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffF9F9F9),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            12.height,
            Center(
              child: ProfilePicture(
                name: '${authController.userModel.value.user?.username}',
                role: '${authController.userModel.value.user?.role}'
                    .toUpperCase(),
                radius: 65,
                fontsize: 32,
                tooltip: true,
              ),
            ),
            12.height,
            Text(
              "${authController.userModel.value.user!.username}",
              style: GoogleFonts.robotoSlab(
                  textStyle: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold)),
            ),
            Spacer(
              flex: 1,
            ),
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Icon(Icons.person,
                        size: 30, color: AppColors.primaryColor),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: TextField(
                      readOnly: true,
                      controller: usernameController,
                      decoration: InputDecoration(
                          labelText: "User Name",
                          labelStyle: GoogleFonts.poppins(fontSize: 17)),
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600),
                    ))
                  ],
                ),
                18.height,
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Icon(Icons.mail,
                        size: 30, color: AppColors.primaryColor),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: TextField(
                      controller: emailController,
                      readOnly: true,
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: GoogleFonts.poppins(fontSize: 17)),
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600),
                    ))
                  ],
                ),
                18.height,
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Icon(Icons.phone,
                        size: 30, color: AppColors.primaryColor),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: TextField(
                      readOnly: true,
                      controller: phoneController,
                      decoration: InputDecoration(
                          labelText: "Phone",
                          labelStyle: GoogleFonts.poppins(fontSize: 17)),
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600),
                    ))
                  ],
                ),
                30.height,
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async{
                          await authController.logout();
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          side: BorderSide(
                              width: 2, color: AppColors.primaryColor),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.logout,
                              size: 30,
                              color: AppColors.primaryColor,
                            ),
                            12.width,
                            Text(
                              "Log Out",
                              style: GoogleFonts.poppins(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(
              flex: 5,
            )
          ],
        ),
      )),
    );
  }
}
