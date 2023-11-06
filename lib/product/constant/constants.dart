import 'package:flutter/material.dart';

class AppImages {
  static const loginImage = 'assets/parking.png';
}

class AppColors {
  static const primaryColor = Color(0xff1E1C61);
}

class APIEndPoints{
   static final String baseUrl = 'https://park-easy-api.onrender.com/';
   static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = 'auth/register/';
  final String loginEmail = 'auth/login/';
}


class GetStorageKeys{
  static const IS_LOGGED_IN = 'IS_LOGGED_IN';
  static const IS_ADMIN = 'IS_ADMIN';
  static const IS_USER = 'IS_USER';
}