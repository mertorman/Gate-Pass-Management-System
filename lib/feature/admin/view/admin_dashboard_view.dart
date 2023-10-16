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
  bool? accepted;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Card(
        elevation: 10,
        child: Container(
          decoration:const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12))),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: GNav(
              backgroundColor: Colors.white,
              color: Colors.grey,
              activeColor: Colors.grey,
              padding: EdgeInsets.all(12),
              gap: 8,
              tabs: [
                GButton(
                  icon: Icons.home,
                  iconActiveColor: Color(0xFF8186dd),
                  iconSize: 27,
                ),
                GButton(
                    icon: Icons.settings,
                    iconActiveColor: Color(0xFF8186dd),
                    iconSize: 27),
                GButton(
                    icon: Icons.home,
                    iconActiveColor: Color(0xFF8186dd),
                    iconSize: 27),
                GButton(
                    icon: Icons.person,
                    iconActiveColor: Color(0xFF8186dd),
                    iconSize: 27)
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffF9F9F9),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color(0xffF9F9F9),
            statusBarIconBrightness: Brightness.dark),
        backgroundColor: Color(0xffF9F9F9),
        toolbarHeight: 65,
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
            padding: const EdgeInsets.only(right: 24,top: 24),
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  color: Color(0xFF8186dd).withOpacity(0.9), borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              child: const Icon(Icons.notifications_none,color: Colors.white,),
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Registration Requests (3)",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "View All",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    )
                  ],
                ),
                12.height,
                Reguest_ListItem_Widget(accepted: accepted),
                12.height,
                Reguest_ListItem_Widget(accepted: accepted),
                12.height,
                Reguest_ListItem_Widget(accepted: accepted),
              ],
            )
          ],
        ),
      ))),
    );
  }
}

class Reguest_ListItem_Widget extends StatefulWidget {
   Reguest_ListItem_Widget({
    super.key,
    required this.accepted,
  });

   bool? accepted;

  @override
  State<Reguest_ListItem_Widget> createState() => _Reguest_ListItem_WidgetState();
}

class _Reguest_ListItem_WidgetState extends State<Reguest_ListItem_Widget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: context.width() * 0.88,
          height: context.height() * 0.12,
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xff4B7FFB).withOpacity(0.1),
              border: Border.all(
                  color: Color(0xff4B7FFB).withOpacity(0.2),
                  width: 1)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(children: [
              const Center(
                child: CircleAvatar(
                  radius: 28,
                  foregroundImage: AssetImage("assets/login.png"),
                ),
              ),
              15.width,
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Elvan Duman",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff1E1C61),
                            fontSize: 14)),
                    8.height,
                    Text("Elvanduman@mehmetakif.edu.tr",
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Color(0xff1E1C61)
                                .withOpacity(0.7))),
                    8.height,
                    Text("(555)555-55-55",
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Color(0xff1E1C61)
                                .withOpacity(0.7))),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          
                          setState(() {
                             widget.accepted = true;
                          });
                        
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(8)),
                            minimumSize:
                                Size(30, context.height() * 0.033),
                            // maximumSize: Size(95, 30),
                            backgroundColor: Color(0xFF8186dd)),
                        child: Text("Accept",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w600))),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                           widget.accepted = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(8)),
                            minimumSize:
                                Size(30, context.height() * 0.033),
                            // maximumSize: Size(95, 30),
                            backgroundColor: Colors.redAccent),
                        child: Text(
                          "Reject",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                        ))
                  ],
                ),
              )
            ]),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
          width: MediaQuery.of(context).size.width * 0.275,
          height: MediaQuery.of(context).size.height * 0.0255,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 16),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: widget.accepted == null
                ? Colors.orange.withOpacity(0.7)
                : widget.accepted == true
                    ? Colors.green.withOpacity(0.7)
                    : Colors.red.withOpacity(0.7),
            borderRadius: BorderRadius.circular(36),
          ),
          child: Text(
            widget.accepted == null
                ? "Waiting"
                : widget.accepted == true
                    ? "Approved"
                    : "Rejected",
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
