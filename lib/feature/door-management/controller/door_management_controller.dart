import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../components/snackbar_content.dart';

class DoorManagementController extends GetxController {
  late double userLatitude;
  late double userLongitude;
  final double circleLatitude = 37.462380; // Dairenin merkezi
  final double circleLongitude = 30.604447; // Dairenin merkezi
  final double circleRadius = 71.40; // Dairenin yarı çapı
  RxBool isInsideCircle = RxBool(false);

  Future<void> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Kullanıcı izin vermediyse, izinleri tekrar talep edebilir veya bir işlem yapabilirsiniz.
    }
  }

  Future<void> getCurrentLocation(BuildContext context) async {
    try {
      // Her butona tıklandığında konum izinlerini kontrol et ve güncel konumu al
      final snackBar = SnackbarContent(
            "Location Control",
            "Your location is being checked, please wait.",
            ContentType.warning);

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Kullanıcı izin vermediyse, izinleri tekrar talep edebilir veya bir işlem yapabilirsiniz.
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      userLatitude = position.latitude;
      userLongitude = position.longitude;

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
    if(isInsideCircle.value){
       final snackBar = SnackbarContent(
            "You are in location!",
            "The door is opening...",
            ContentType.success);

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
    }else{
      final snackBar = SnackbarContent(
            "You are not in location!",
            "You need to be around the school to manage the gate.",
            ContentType.failure);

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
    }
  }
}
