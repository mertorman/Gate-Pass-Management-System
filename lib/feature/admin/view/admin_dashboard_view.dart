import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gate_pass_management/feature/admin/model/stats_model.dart';
import 'package:gate_pass_management/feature/components/stats_component.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF4F4F7), Color(0xFFffffff)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Color(0xFFF4F4F7)),
          backgroundColor: Colors.transparent,
          toolbarHeight: 75,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 24, top: 24),
            child: Text(
              "ParkEasy",
              style: GoogleFonts.robotoSlab(
                  textStyle: TextStyle(
                      color: Color(0xFF8186dd),
                      fontSize: 25,
                      fontWeight: FontWeight.w500)),
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
                child: Icon(Icons.notifications_none),
                alignment: Alignment.center,
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
                padding: EdgeInsets.all(8.0),
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
              )
            ],
          ),
        ))),
      ),
    );
  }
}
