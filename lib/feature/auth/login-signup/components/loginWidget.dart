import 'package:flutter/material.dart';
import 'package:gate_pass_management/feature/admin/view/admin_dashboard_view.dart';
import 'package:gate_pass_management/feature/user/view/user_view.dart';
//import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class LoginWidget extends StatefulWidget {
  LoginWidget({super.key, required this.pageController});
  PageController pageController;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: context.width() * 0.8,
          height: context.height() * 0.07,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                10.width,
                const Icon(Icons.mail_lock_outlined),
                20.width,
                Expanded(
                    child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                      hintText: "Enter email", border: InputBorder.none),
                  style: GoogleFonts.poppins(fontSize: 16),
                ))
              ],
            ),
          ),
        ),
        25.height,
        Container(
          width: context.width() * 0.8,
          height: context.height() * 0.07,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                10.width,
                const Icon(Icons.lock_outline),
                20.width,
                Expanded(
                    child: TextField(
                      obscureText: true,
                      controller: password,
                  decoration: InputDecoration(
                      hintText: "Enter password", border: InputBorder.none),
                  style: GoogleFonts.poppins(fontSize: 16),
                ))
              ],
            ),
          ),
        ),
        24.height,
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                maximumSize:
                    Size(context.width() * 0.8, context.height() * 0.07),
                minimumSize:
                    Size(context.width() * 0.5, context.height() * 0.07),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
            onPressed: () {
              if(email.text=="admin@gmail.com" && password.text == "123456"){
                Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return AdminDashboard();
                },
              ));
              }else{
                Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return UserPage();
                },
              ));
              }
              
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Text("Continue"), 8.width, Icon(Icons.arrow_forward)],
            )),
        24.height,
        Row(
          children: [
            const Expanded(
                child: Divider(
              thickness: 1,
              color: Colors.white,
            )),
            Text(
              "Or",
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            const Expanded(
                child: Divider(
              color: Colors.white,
              thickness: 1,
            ))
          ],
        ),
        24.height,
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                maximumSize:
                    Size(context.width() * 0.8, context.height() * 0.07),
                minimumSize:
                    Size(context.width() * 0.5, context.height() * 0.07),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
            onPressed: () {
              widget.pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Text("Sign Up"), 8.width, Icon(Icons.arrow_forward)],
            )),
      ],
    );
  }
}
