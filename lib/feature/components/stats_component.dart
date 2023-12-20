import 'package:flutter/material.dart';
import 'package:gate_pass_management/feature/admin/controller/admin_controller.dart';
import 'package:gate_pass_management/feature/user/components/user_access_widget.dart';
import 'package:get/get.dart' hide ContextExtensionss;
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../product/constant/constants.dart';

// ignore: must_be_immutable
class StatsWidget extends StatefulWidget {
  StatsWidget({
    super.key,
    required this.title,
    required this.number,
    required this.color,
    required this.index,
  });
  Color color;
  String number;
  String title;
  int index;

  @override
  State<StatsWidget> createState() => _StatsWidgetState();
}

class _StatsWidgetState extends State<StatsWidget>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  Widget buildEntryList() {
    AdminController adminController = Get.find();
    final usernameList = adminController.allEntryHistory.keys.toList();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: adminController.allEntryHistory.length,
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        final username = usernameList[index];
        final entryHistory = adminController.allEntryHistory[username] ?? [];
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: context.width(),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryColor, width: 1),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  10.height,
                  Text("$username's Login Information",style: GoogleFonts.poppins(color: AppColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 15),),
                  20.height,
                  for (int entryIndex = 0;
                      entryIndex < entryHistory.length;
                      entryIndex++)
                    Column(
                      children: [
                        UserAccessWidget(
                          username: username,
                          date: entryHistory[entryIndex].entryDate!,
                          time: entryHistory[entryIndex].entryTime!.split(":"),
                          message: "Logged In",
                          login: true,
                        ),
                        12.height
                      ],
                    ),
                ],
              ),
            ),
            12.height,
          ],
        );
      },
    );
  }

  Widget buildExitList() {
    AdminController adminController = Get.find();
    final usernameList = adminController.allExitHistory.keys.toList();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: adminController.allExitHistory.length,
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        final username = usernameList[index];
        final exitHistory = adminController.allExitHistory[username] ?? [];
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: context.width(),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryColor, width: 1),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  10.height,
                  Text("$username's Exit Information",style: GoogleFonts.poppins(color: AppColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 15),),
                  20.height,
                  for (int exitIndex = 0;
                      exitIndex < exitHistory.length;
                      exitIndex++)
                    Column(
                      children: [
                        UserAccessWidget(
                          username: username,
                          date: exitHistory[exitIndex].exitDate!,
                          time: exitHistory[exitIndex].exitTime!.split(":"),
                          message: "Exit Out",
                          login: false,
                        ),
                        12.height
                      ],
                    ),
                ],
              ),
            ),
            12.height,
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.index == 3
          ? () async {
              AdminController adminController = Get.find();
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  adminController.getAllLatestGateInfo();
                  return Container(
                    height: context.height() * 0.55,
                    width: context.width(),
                    decoration: const BoxDecoration(
                        color: Color(0xffF9F9F9),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18))),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          DefaultTabController(
                              initialIndex: 0,
                              length: 2,
                              child: TabBar(
                                controller: tabController,
                                tabs: [
                                  Tab(
                                    child: Text(
                                      'All Entries',
                                      style: GoogleFonts.poppins(
                                          color: AppColors.primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      'All Exits',
                                      style: GoogleFonts.poppins(
                                          color: AppColors.primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              )),
                          20.height,
                          Expanded(
                            child: TabBarView(
                              controller: tabController,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                Obx(() => adminController.isLoadingData.value
                                    ? Center(child: CircularProgressIndicator())
                                    : buildEntryList()),
                                Obx(() => adminController.isLoadingData.value
                                    ? Center(child: CircularProgressIndicator())
                                    : buildExitList()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          : null,
      child: Card(
        elevation: 1.5,
        child: Container(
          decoration: BoxDecoration(
              color: widget.color, borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 33,
                      height: 33,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(8)),
                      child: Icon(
                        Icons.person_outlined,
                        color: widget.color,
                      ),
                    ),
                    widget.index == 3
                        ? Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
 // border color
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(2), // border width
                              child: Container(
                                // or ClipRRect if you need to clip the content
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green, // inner circle color
                                ),
                                child: Container(), // inner content
                              ),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${widget.number}",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                        Text(
                          "${widget.title}",
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 13),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
