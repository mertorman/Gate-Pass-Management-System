import 'package:flutter/material.dart';
import 'package:gate_pass_management/feature/admin/controller/admin_controller.dart';
import 'package:gate_pass_management/feature/admin/model/stats_model.dart';
import 'package:gate_pass_management/feature/components/stats_component.dart';
import 'package:gate_pass_management/product/constant/constants.dart';
import 'package:get/get.dart' hide ContextExtensionss;
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import '../components/request_listitem_widget.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  AdminController adminController = Get.put(AdminController());
  bool? accepted;

  void handleAcceptPressed(int index){
    adminController.unapprovedAccounts[index].isApproved=!adminController.unapprovedAccounts[index].isApproved;
    adminController.unapprovedAccounts.refresh();
    adminController
        .confirmAccount(adminController.unapprovedAccounts[index].id);
  }

  @override
  Widget build(BuildContext context) {
    print(adminController.accepted.value);
    return adminController
        .obx(onLoading: Center(child: CircularProgressIndicator()), (state) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xffF9F9F9),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8.0),
                  itemCount: StatsModels.statsModels.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: (1 / .73),
                      crossAxisCount: 2,
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 12),
                  itemBuilder: (context, index) {
                    return StatsWidget(
                      title: StatsModels.statsModels[index].title!,
                      number: StatsModels.statsModels[index].number!,
                      color: StatsModels.statsModels[index].color,
                    );
                  },
                ),
                24.height,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Registration Requests",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () {
                            adminController.unapprovedGetAccounts();
                          },
                          child: Text(
                            "View All",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: AppColors.primaryColor),
                          ),
                        )
                      ],
                    ),
                    12.height,
                    SizedBox(
                      height: context.height() * 0.4,
                      child: Obx(
                        () => ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: adminController.unapprovedAccounts.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Obx(
                                  () => Reguest_ListItem_Widget(
                                      accepted: adminController.unapprovedAccounts[index].isApproved,
                                      acceptPressed: () =>
                                          handleAcceptPressed(index),
                                      email: adminController
                                          .unapprovedAccounts[index].email,
                                      name: adminController
                                          .unapprovedAccounts[index].username,
                                      phone: adminController
                                          .unapprovedAccounts[index].phone),
                                ),
                                15.height,
                              ],
                            );
                          },
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )),
      );
    });
  }
}
