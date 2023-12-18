import 'package:flutter/material.dart';

class AppImages {
  static const loginImage = 'assets/parking.png';
}

class AppColors {
  static const primaryColor = Color(0xff1E1C61);
}

class APIEndPoints {
  static final String baseUrl = 'http://107.23.189.238:8080/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = 'auth/register/';
  final String loginEmail = 'auth/login/';
  final String currentUser = 'user/';
  final String getUsers = 'users/';
  final String confirmAccount = 'user/approve/';
  final String rejectAccount = 'user/block/';
  final String getAllApprovedAccounts = 'users/';
  final String logout = "auth/logout/";
}

class GetStorageKeys {
  static const IS_LOGGED_IN = 'IS_LOGGED_IN';
  static const IS_ADMIN = 'IS_ADMIN';
  static const IS_USER = 'IS_USER';
}
