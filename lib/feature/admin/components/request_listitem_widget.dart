import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class Reguest_ListItem_Widget extends StatefulWidget {
  Reguest_ListItem_Widget(
      {super.key,
      required this.accepted,
      required this.blocked,
      required this.email,
      required this.name,
      required this.phone,
      this.acceptPressed,
      this.rejectPressed,
      required this.getAllUsersWidgetUsed,
      required this.getAllBlockedWidgetUsed
      });

  bool? accepted;
  bool? blocked;
  String? email;
  String? name;
  String? phone;
  VoidCallback? acceptPressed;
  VoidCallback? rejectPressed;
  bool getAllUsersWidgetUsed;
  bool getAllBlockedWidgetUsed;

  @override
  State<Reguest_ListItem_Widget> createState() =>
      _Reguest_ListItem_WidgetState();
}

class _Reguest_ListItem_WidgetState extends State<Reguest_ListItem_Widget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: context.width() * 0.88,
          height: widget.getAllUsersWidgetUsed
              ? context.height() * 0.1
              : context.height() * 0.12,
          margin: widget.getAllUsersWidgetUsed
              ? const EdgeInsets.only(top: 15)
              : const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xff4B7FFB).withOpacity(0.1),
              border: Border.all(
                  color: Color(0xff4B7FFB).withOpacity(0.2), width: 1)),
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
                    Text("${widget.name}",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1E1C61),
                          fontSize: 14,
                        )),
                    6.height,
                    Text("${widget.email}",
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Color(0xff1E1C61).withOpacity(0.7))),
                    8.height,
                    Text("${widget.phone}",
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Color(0xff1E1C61).withOpacity(0.7))),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: widget.getAllUsersWidgetUsed
                        ? MainAxisAlignment.center : MainAxisAlignment.spaceAround,
                  children: [
                    ((widget.getAllUsersWidgetUsed && widget.getAllBlockedWidgetUsed) || (widget.getAllUsersWidgetUsed == false && widget.getAllBlockedWidgetUsed==false)) ?
                    ElevatedButton(
                            onPressed: widget.acceptPressed,
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18.0, vertical: 5.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                minimumSize: Size(context.width() * 0.08,
                                    context.height() * 0.033),
                                // maximumSize: Size(95, 30),
                                backgroundColor: Color(0xFF8186dd)),
                            child: Text( (widget.getAllUsersWidgetUsed && widget.getAllBlockedWidgetUsed) ? "Unblock" : "Accept",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600))) : SizedBox(),
                    ((widget.getAllUsersWidgetUsed && widget.getAllBlockedWidgetUsed==false) || (widget.getAllUsersWidgetUsed == false && widget.getAllBlockedWidgetUsed==false)) ? ElevatedButton(
                        onPressed: widget.rejectPressed,
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 5.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            minimumSize: Size(context.width() * 0.08,
                                context.height() * 0.033),
                            // maximumSize: Size(95, 30),
                            backgroundColor: Colors.redAccent),
                        child: Text(
                         widget.getAllUsersWidgetUsed
                        ? "Block" : "Reject",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                        )) : SizedBox()
                  ],
                ),
              )
            ]),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeIn,
          width: MediaQuery.of(context).size.width * 0.28,
          height: widget.getAllUsersWidgetUsed
              ? MediaQuery.of(context).size.height * 0.025
              : MediaQuery.of(context).size.height * 0.0255,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 16),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: widget.blocked == true
                ? Colors.red.withOpacity(0.7)
                : (widget.accepted == true && widget.blocked == false) || widget.getAllBlockedWidgetUsed
                    ? Colors.green.withOpacity(0.7)
                    : Colors.orange.withOpacity(0.7),
            borderRadius: BorderRadius.circular(36),
          ),
          child: Text(
            widget.blocked == true
                ? "Rejected"
                : (widget.accepted == true && widget.blocked == false) || widget.getAllBlockedWidgetUsed
                    ? "Approved"
                    : "Waiting",
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
