import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:gate_pass_management/feature/auth/login-signup/controller/auth_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../components/snackbar_content.dart';

class DoorManagementController extends GetxController {
  AuthController authController = Get.find();
  late double userLatitude;
  late double userLongitude;
  final double circleLatitude = 37.462380; // Dairenin enlemi
  final double circleLongitude = 30.604447; // Dairenin boylamı
  final double circleRadius = 71.40; // Dairenin yarı çapı
  RxBool isInsideCircle = RxBool(false);
  DateTime now = DateTime.now();
  late String formattedDate;
  late String formattedHour;
  RxString entryTime = RxString("N/A");
  RxString exitTime = RxString("N/A");


  @override
  void onInit() {
    formattedDate = DateFormat.yMMMMd().format(now);
    super.onInit();
  }

  //Future<void> requestLocationPermission() async {
  //  LocationPermission permission = await Geolocator.requestPermission();
  //  if (permission == LocationPermission.denied) {
  //    // Kullanıcı izin vermediyse, izinleri tekrar talep edebilir veya bir işlem yapabilirsiniz.
  //  }
  // }

  String getSystemTime() {
    DateTime now2 = DateTime.now();
    formattedHour = DateFormat.Hms().format(now2);
    return formattedHour;
  }

  Future<void> getCurrentLocation(BuildContext context) async {
    try {
      // Her butona tıklandığında konum izinlerini kontrol et ve güncel konumu al

      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        final snackBar = SnackbarContent(
            "Location Control",
            "Your location is being checked, please wait.",
            ContentType.warning);

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } else if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          final snackBar = SnackBar(
            content: Text('Konum izinleri reddedildi.'),
            action: SnackBarAction(
              label: 'Tamam',
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      userLatitude = position.latitude;
      userLongitude = position.longitude;

      // ignore: use_build_context_synchronously
      _checkIfUserInsideCircle(context);
      print("$userLatitude ,, $userLongitude");
    } catch (e) {
      print('Konum alınamıyor: $e');
    }
  }

  void _checkIfUserInsideCircle(BuildContext context) {
    double distance = Geolocator.distanceBetween(
      userLatitude,
      userLongitude,
      circleLatitude,
      circleLongitude,
    );

    isInsideCircle.value = distance <= circleRadius;
    if (isInsideCircle.value) {
      final snackBar = SnackbarContent("You are in location!",
          "The door is opening...", ContentType.success);

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else {
      final snackBar = SnackbarContent(
          "You are not in location!",
          "You need to be around the school to manage the gate.",
          ContentType.failure);

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      Future.delayed(Duration(seconds: 3), () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      });
    }
  }

  Future<void> entryCarPark() async {
    try {
      Map body = {
        "username": authController.userModel.value.user?.username,
        "date": formattedDate,
        "time": getSystemTime(),
        "type": "Logged In",
      };
    } catch (e) {
      print(e);
    }
  }
}
