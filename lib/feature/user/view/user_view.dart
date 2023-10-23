import 'package:flutter/material.dart';
import 'package:gate_pass_management/feature/components/appbar_component.dart';
import 'package:gate_pass_management/feature/components/stats_component.dart';
import 'package:gate_pass_management/feature/user/model/stats_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../components/bottom_navigation_bar.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      bottomNavigationBar: NavigationBarBottom(),
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffF9F9F9),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              GridView.builder(
                itemCount: UserStatsModels.userStatsModels.length,
                shrinkWrap: true,
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: (1 / .73),
                    crossAxisCount: 2,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 12),
                itemBuilder: (context, index) {
                  return StatsWidget(
                      title: UserStatsModels.userStatsModels[index].title!,
                      number: UserStatsModels.userStatsModels[index].number!,
                      color: UserStatsModels.userStatsModels[index].color);
                },
              ),
              24.height,
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Visits (Last 10)",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: context.height() / 1.25,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                   borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          "View All",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      )
                    ],
                  ),
                  12.height,
                  Stack(
                    children: [
                      Container(
                        width: context.width() * 0.88,
                        height: context.height() * 0.09,
                        margin: const EdgeInsets.only(top: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xff4B7FFB).withOpacity(0.1),
                            border: Border.all(
                                color: Color(0xff4B7FFB).withOpacity(0.2),
                                width: 1)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: const Center(
                                  child: CircleAvatar(
                                      radius: 26,
                                      foregroundImage:
                                          AssetImage("assets/login.png")),
                                ),
                              ),
                              12.width,
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Elvan Duman",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                          color: Color(0xff1E1C61),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      "Logged In",
                                      style: GoogleFonts.poppins(fontSize: 12,color: Color(0xff1E1C61).withOpacity(0.7)),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '14',
                                      style: const TextStyle(
                                          color: Color(0xFF3b67b5),
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 12, left: 0),
                                      child: Text(
                                          ':56', //Dinamik hale getirelecek.
                                          style: TextStyle(
                                              color: Color(0xFF3b67b5),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                        width: MediaQuery.of(context).size.width * 0.28,
                        height: MediaQuery.of(context).size.height * 0.0255,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 13),
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(36),
                        ),
                        child: Text(
                          "22.10.2023",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
