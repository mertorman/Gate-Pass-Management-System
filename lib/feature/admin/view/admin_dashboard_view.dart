import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gate_pass_management/feature/admin/model/stats_model.dart';
import 'package:gate_pass_management/feature/components/stats_component.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF4F4F7), Color(0xFFffffff)])),
      child: Scaffold(
        bottomNavigationBar: Card(
          elevation: 10,
          child: Container(
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))),
          
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
              child: GNav(
                backgroundColor: Colors.white,
                color: Colors.grey,
                activeColor: Colors.grey,
             
                padding: EdgeInsets.all(16),
                gap: 8,
                tabs: [
                  GButton(icon: Icons.home,iconActiveColor: Color(0xFF8186dd),iconSize: 27,),
                  GButton(icon: Icons.settings,iconActiveColor: Color(0xFF8186dd),iconSize: 27),
                  GButton(icon: Icons.home,iconActiveColor: Color(0xFF8186dd),iconSize: 27),
                  GButton(icon: Icons.person,iconActiveColor: Color(0xFF8186dd),iconSize: 27)
                ],
              ),
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Color(0xFFF4F4F7),
              statusBarIconBrightness: Brightness.dark),
          backgroundColor: Colors.transparent,
          toolbarHeight: 75,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 24, top: 24),
            child: Text(
              "ParkEasy",
              style: GoogleFonts.robotoSlab(
                  textStyle: const TextStyle(
                      color: Color(0xFF8186dd),
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          leadingWidth: 180,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
                child: const Icon(Icons.notifications_none),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: SafeArea(
                child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8.0),
                itemCount: StatsModels.statsModels.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: (1 / .75),
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Registration Requests (3)",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "View All",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      )
                    ],
                  ),
                  12.height,
                  Container(
                    width: context.width() * 0.88,
                    height: context.height() * 0.12,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.blueGrey.shade200.withOpacity(0.5),
                            width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Center(
                              child: CircleAvatar(
                                radius: 29,
                                foregroundImage: AssetImage("assets/login.png"),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Maria Martinez",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey.shade800,
                                        fontSize: 16)),
                                5.height,
                                Text("Phone: 5555555555",
                                    style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: Colors.blueGrey.shade700)),
                                5.height,
                                Text("Status: Pending",
                                    style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: Colors.blueGrey.shade700))
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    onPressed: () {},
                                    child: Text("Accept",
                                    style: GoogleFonts.poppins(fontSize: 11,color: Colors.white,fontWeight: FontWeight.w600)),
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        minimumSize: Size(30, context.height()*0.033),
                                        // maximumSize: Size(95, 30),
                                        backgroundColor: Color(0xFF8186dd))
                                    ),
                                ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Reject",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white, fontSize: 11,fontWeight: FontWeight.w600),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        minimumSize: Size(30, context.height()*0.033),
                                     // maximumSize: Size(95, 30),
                                        backgroundColor: Colors.redAccent))
                              ],
                            )
                          ]),
                    ),
                  )
                ],
              )
            ],
          ),
        ))),
      ),
    );
  }
}
