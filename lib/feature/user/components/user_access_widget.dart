import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class UserAccessWidget extends StatelessWidget {
  UserAccessWidget(
      {super.key,
      required this.username,
      required this.date,
      required this.time,
      required this.message,
      required this.login
      
      });

  String username;
  String date;
  List<String> time;
  String message;
  bool login;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
                      color: Color(0xff4B7FFB).withOpacity(0.2), width: 1)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child:  Center(
                        child: ProfilePicture(
                        name: '${username}',
                        radius: 26,
                        fontsize: 19,
                        tooltip: true,
                      )
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
                            "$username",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                color: Color(0xff1E1C61),
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                          Text(
                            "$message",
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Color(0xff1E1C61).withOpacity(0.7)),
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
                            '${time[0]}',
                            style: const TextStyle(
                                color: Color(0xFF3b67b5),
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 12, left: 0),
                            child: Text(
                                ':${time[1]}', //Dinamik hale getirelecek.
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
                color:  login ? Colors.green.withOpacity(0.7) : Colors.red.withOpacity(0.7) ,
                borderRadius: BorderRadius.circular(36),
              ),
              child: Text(
                "$date",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ],
    );
  }
}
