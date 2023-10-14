import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class SignUpWidget extends StatelessWidget {
    SignUpWidget({
    super.key,
    required this.pageController
  });
  PageController pageController;
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
                const Icon(Icons.person),
                20.width,
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                      hintText: "Enter Full Name", border: InputBorder.none),
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
                const Icon(Icons.mail_lock_outlined),
                20.width,
                Expanded(
                    child: TextField(
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
                  decoration: InputDecoration(
                      hintText: "Enter password", border: InputBorder.none),
                  style: GoogleFonts.poppins(fontSize: 16),
                ))
              ],
            ),
          ),
        ),
        24.height,
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
                  decoration: InputDecoration(
                      hintText: "Confirm password", border: InputBorder.none),
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
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Text("Sign Up"), 8.width, Icon(Icons.arrow_forward)],
            )),
        8.height,
        TextButton(
            onPressed: () {
              pageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back,color: Colors.white,),
                Text(
                  "Login Page",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ],
            ))
      ],
    );
  }
}