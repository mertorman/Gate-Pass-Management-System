import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gate_pass_management/feature/auth/login-signup/controller/auth_controller.dart';
import 'package:gate_pass_management/feature/door-management/controller/door_management_controller.dart';
import 'package:get/get.dart' hide ContextExtensionss;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:timer_builder/timer_builder.dart';

class DoorManagementPage extends StatefulWidget {
  const DoorManagementPage({super.key});

  @override
  State<DoorManagementPage> createState() => _DoorManagementPageState();
}

class _DoorManagementPageState extends State<DoorManagementPage> {
  DoorManagementController doorManagementController =
      Get.put(DoorManagementController());
  DateTime now2 = DateTime.now();
  late String formattedDate;
  late String formattedHour;
  AuthController authController = Get.find();

  String getSystemTime() {
    DateTime now = DateTime.now();
    formattedHour = DateFormat.Hms().format(now);
    return formattedHour;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffF9F9F9),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            12.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Good Morning,",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: Color(0xff1E1C61),
                          fontSize: 18,
                        )),
                    Text("${authController.userModel.value.user?.username}",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1E1C61),
                          fontSize: 21,
                        )),
                  ],
                ),
                 Center(
                    child: ProfilePicture(
                  name: '${authController.userModel.value.user?.username}',
                  role: '${authController.userModel.value.user?.role}'.toUpperCase(),
                  radius: 31,
                  fontsize: 21,
                  tooltip: true,
                )),
              ],
            ),
            Spacer(
              flex: 1,
            ),
            Card(
              color: Colors.white,
              child: Container(
                width: context.width() * 0.8,
                height: context.height() * 0.05,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        width: 2, color: Color(0xff1E1C61).withOpacity(0.5))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 3),
                        child: Icon(
                          Icons.location_pin,
                          color: Color(0xff1E1C61),
                        ),
                      ),
                      Text(
                        "Bucak Technology Faculty",
                        style: GoogleFonts.poppins(color: Color(0xff1E1C61)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            TimerBuilder.periodic(
              Duration(seconds: 1),
              builder: (context) {
                return Text(
                  "${doorManagementController.getSystemTime()}",
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Color(0xff1E1C61),
                      fontWeight: FontWeight.w500),
                );
              },
            ),
            Text(
              "${doorManagementController.formattedDate}",
              style: GoogleFonts.poppins(
                  fontSize: 16, color: Color(0xff1E1C61).withOpacity(0.8)),
            ),
            Spacer(
              flex: 1,
            ),
            InkWell(
              splashColor: Colors.red.withOpacity(0.8),
              customBorder: const CircleBorder(),
              onTap: () async {
                await doorManagementController.getCurrentLocation(context);
                print(doorManagementController.isInsideCircle);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  color: Color(0xff1E1C61).withOpacity(0.25), // border color
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(3), // border width
                  child: Container(
                    // or ClipRRect if you need to clip the content
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff1E1C61)
                          .withOpacity(0.8), // inner circle color
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff1E1C61).withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/login_icon.svg",
                            width: MediaQuery.of(context).size.width * 0.038,
                            height: MediaQuery.of(context).size.height * 0.038,
                          ),
                          12.height,
                          Text(
                            "Open",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )
                        ],
                      ),
                    ), // inner content
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Entry time",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      5.height,
                      Obx(
                        () => Text(
                          "${doorManagementController.entryTime}",
                          style: GoogleFonts.poppins(fontSize: 15),
                        ),
                      )
                    ],
                  ),
                  VerticalDivider(
                    thickness: 1,
                    color: Colors.grey.withOpacity(0.8),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Exit time",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      5.height,
                      Obx(() => Text("${doorManagementController.exitTime}",
                          style: GoogleFonts.poppins(fontSize: 15)))
                    ],
                  )
                ],
              ),
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      )),
    );
  }
}
