import 'package:gate_pass_management/feature/admin/view/admin_dashboard_view.dart';
import 'package:gate_pass_management/feature/auth/login-signup/view/login_signup_view.dart';
import 'package:gate_pass_management/feature/door-management/view/door_management_view.dart';
import 'package:gate_pass_management/feature/main-wrapper/main_wrapper.dart';
import 'package:gate_pass_management/feature/splash/view/splash_view.dart';
import 'package:gate_pass_management/feature/user/view/user_view.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/login',
      page: () => const LoginPage(),
    ),
    GetPage(
      name: '/admindashboard',
      page: () => const AdminDashboard(),
    ),
    GetPage(
      name: '/userdashboard',
      page: () => const UserPage(),
    ),
    GetPage(name: '/doormanagement', page: () => const DoorManagementPage(),),
    GetPage(name: '/mainwrapper', page: () => MainWrapper(),),
    GetPage(name: '/splashpage', page: () => SplashPage(),)
  ];
}
