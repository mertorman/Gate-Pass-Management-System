import 'package:flutter/material.dart';

class AppImages {
  static const loginImage = 'assets/login.png';
}

class AppColors {
  static const primaryColor = Color(0xff1E1C61);
}

class APIEndPoints{
   static final String baseUrl = 'http://restapi.adequateshop.com/api/';
   static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = 'authaccount/registration';
  final String loginEmail = 'authaccount/login';
}