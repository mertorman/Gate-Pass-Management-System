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
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  void handleAcceptPressed(int index) {
    adminController.unapprovedAccounts[index].isApproved =
        !adminController.unapprovedAccounts[index].isApproved;
    adminController.unapprovedAccounts.refresh();
    adminController
        .confirmAccount(adminController.unapprovedAccounts[index].id);
  }

  @override
  Widget build(BuildContext context) {
    return adminController
        .obx(onLoading: Center(child: CircularProgressIndicator()), (state) {
      return Scaffold(
        extendBody: false,
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xffF9F9F9),
        body: RefreshIndicator(
          color: AppColors.primaryColor,
          key: _refreshIndicatorKey,
          onRefresh: () async {
            adminController.onInit();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8.0),
                    itemCount: StatsModels.statsModels.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                              adminController.getAllAprovedAccounts();
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: context.height() * 0.55,
                                    width: context.width(),
                                    decoration: const BoxDecoration(
                                        color: Color(0xffF9F9F9),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(18),
                                            topRight: Radius.circular(18))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Obx(
                                        () => Column(
                                          children: [
                                            Text(
                                              'All Approved Accounts',
                                              style: GoogleFonts.poppins(
                                                  color: AppColors.primaryColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Divider(thickness: 1,color: Colors.grey.withOpacity(0.3),),
                                            adminController.isLoadingData.value
                                                ? const Expanded(
                                                    child: Center(
                                                        child:
                                                            CircularProgressIndicator()))
                                                : Expanded(
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: adminController
                                                          .allapprovedAccounts
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              10.height,
                                                              Reguest_ListItem_Widget(
                                                                  accepted: adminController
                                                                      .allapprovedAccounts[
                                                                          index]
                                                                      .isApproved,
                                                                  email: adminController
                                                                      .allapprovedAccounts[
                                                                          index]
                                                                      .email,
                                                                  name: adminController
                                                                      .allapprovedAccounts[
                                                                          index]
                                                                      .username,
                                                                  phone: adminController
                                                                      .allapprovedAccounts[
                                                                          index]
                                                                      .phone,
                                                                  getAllUsersWidgetUsed:
                                                                      true),
                                                                      
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(
                              "All Users",
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
                        height: context.height() * 0.36,
                        child: Obx(
                          () => ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount:
                                adminController.unapprovedAccounts.length,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Obx(
                                    () => Reguest_ListItem_Widget(
                                      accepted: adminController
                                          .unapprovedAccounts[index].isApproved,
                                      acceptPressed: () =>
                                          handleAcceptPressed(index),
                                      email: adminController
                                          .unapprovedAccounts[index].email,
                                      name: adminController
                                          .unapprovedAccounts[index].username,
                                      phone: adminController
                                          .unapprovedAccounts[index].phone,
                                      getAllUsersWidgetUsed: false,
                                    ),
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
            )),
          ),
        ),
      );
    });
  }
}
