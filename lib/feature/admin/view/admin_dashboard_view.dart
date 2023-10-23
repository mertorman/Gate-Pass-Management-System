import 'package:flutter/material.dart';
import 'package:gate_pass_management/feature/admin/model/stats_model.dart';
import 'package:gate_pass_management/feature/components/bottom_navigation_bar.dart';
import 'package:gate_pass_management/feature/components/stats_component.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../components/appbar_component.dart';
import '../components/request_listitem_widget.dart';


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
      bottomNavigationBar: NavigationBarBottom(),
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffF9F9F9),
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
        padding: const EdgeInsets.all(12.0),
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
                      "Registration Requests",
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


