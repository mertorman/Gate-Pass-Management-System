import 'package:flutter/material.dart';
import 'package:gate_pass_management/feature/auth/login-signup/controller/auth_controller.dart';
import 'package:gate_pass_management/feature/components/stats_component.dart';
import 'package:gate_pass_management/feature/user/controller/user_controller.dart';
import 'package:get/get.dart' hide ContextExtensionss;
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../product/constant/constants.dart';
import '../components/user_access_widget.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserController userController = Get.put(UserController());
  AuthController authController = Get.find();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final PageController pageController = PageController(initialPage: 0);

  Widget buildEntryList() {
    return userController.entryHistory!.isEmpty
        ? Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Spacer(
              flex: 2,
            ),
            Text(
              "Latest entries not found",
              style: GoogleFonts.poppins(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            LottieBuilder.asset(
              "assets/animation/not_found.json",
              height: context.height() * 0.4,
              width: context.height() * 0.4,
            ),
            Spacer(
              flex: 1,
            ),
          ])
        : ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: userController.entryHistory?.length,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  UserAccessWidget(
                    username: authController.userModel.value.user!.username!,
                    date: userController.entryHistory![index].entryDate!,
                    time: userController.entryHistory![index].entryTime!
                        .split(":"),
                    message: "Logged In",
                    login: true,
                  ),
                  index == userController.entryHistory!.length - 1
                      ? SizedBox()
                      : 16.height,
                ],
              );
            },
          );
  }

  Widget buildExitList() {
    return userController.exitHistory!.isEmpty
        ? Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Spacer(
              flex: 2,
            ),
            Text(
              "Latest exits not found",
              style: GoogleFonts.poppins(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            LottieBuilder.asset(
              "assets/animation/not_found.json",
              height: context.height() * 0.4,
              width: context.height() * 0.4,
            ),
            Spacer(
              flex: 1,
            ),
          ])
        : ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: userController.exitHistory?.length,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  UserAccessWidget(
                      username: authController.userModel.value.user!.username!,
                      date: userController.exitHistory![index].exitDate!,
                      time: userController.exitHistory![index].exitTime!
                          .split(":"),
                      message: "Exit Out",
                      login: false),
                  index == userController.exitHistory!.length - 1
                      ? SizedBox()
                      : 16.height,
                ],
              );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return userController
        .obx(onLoading: Center(child: CircularProgressIndicator()), (state) {
      return Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xffF9F9F9),
        body: RefreshIndicator(
          color: AppColors.primaryColor,
          key: _refreshIndicatorKey,
          onRefresh: () async {
            userController.onInit();
          },
          child: SafeArea(
              child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                GridView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: (1 / .73),
                      crossAxisCount: 2,
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 12),
                  itemBuilder: (context, index) {
                    return StatsWidget(
                        title: index == 0 ? "Total Entries" : "Total Exits",
                        number: index == 0 ? userController.entryHistory!.length.toString() : userController.exitHistory!.length.toString(),
                        color: index == 0 ? Colors.green.shade300 : Colors.deepPurple.shade300,
                        index: index,
                        );
                  },
                ),
                24.height,
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              pageController.previousPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            child: Obx(
                              () => Text(
                                "Latest Entries",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: userController.currentPage == 1
                                        ? Colors.grey.withOpacity(0.7)
                                        : null),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            child: Obx(
                              () => Text(
                                "Latest Exits",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: userController.currentPage == 0
                                      ? Colors.grey.withOpacity(0.7)
                                      : null,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      12.height,
                      Expanded(
                          child: PageView(
                        controller: pageController,
                        onPageChanged: (index) {
                          userController.currentPage.value = index;
                        },
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          buildEntryList(),
                          buildExitList(),
                        ],
                      )),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ),
      );
    });
  }
}
