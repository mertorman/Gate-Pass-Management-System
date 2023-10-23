import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavigationBarBottom extends StatelessWidget {
  const NavigationBarBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
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
    );
  }
}
