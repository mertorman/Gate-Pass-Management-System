import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:gate_pass_management/feature/auth/login-signup/controller/auth_controller.dart';
import 'package:gate_pass_management/feature/door-management/models/gate_access_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../network/networkUtils.dart';
import '../../../product/constant/constants.dart';
import '../../components/snackbar_content.dart';

class DoorManagementController extends GetxController with StateMixin {
  AuthController authController = Get.find();
  late double userLatitude;
  late double userLongitude;
  final double circleLatitude = 37.462414; // Dairenin enlemi
  final double circleLongitude = 30.604458; // Dairenin boylamı
  final double circleRadius = 150.08; // Dairenin yarı çapı
  RxBool isInsideCircle = RxBool(false);
  DateTime now = DateTime.now();
  late String formattedDate;
  late String formattedDate2;
  late String formattedHour;
  RxString entryTime = RxString("N/A");
  RxString exitTime = RxString("N/A");

  RxBool isInside = RxBool(false);
  RxBool isButtonDisabled = RxBool(false);

  NetworkUtils networkUtils = NetworkUtils();
  Rx<GateAccessModel> gateAccessModel = GateAccessModel().obs;
  set setGateAccessModel(GateAccessModel value) =>
      gateAccessModel.value = value;

  @override
  void onInit() async {
    formattedDate = DateFormat.yMMMMd().format(now);
    formattedDate2 = DateFormat('dd.MM.yyyy').format(now);
    change(null, status: RxStatus.loading());
    await getLatestGateInfo();
    change(null, status: RxStatus.success());
    super.onInit();
  }

  String getSystemTime(bool formatHHmm) {
    DateTime now2 = DateTime.now();
    formattedHour = DateFormat.Hms().format(now2);
    if (formatHHmm) {
      String formatHHmmHour = DateFormat('HH:mm').format(now2);
      return formatHHmmHour;
    } else {
      return formattedHour;
    }
  }

  Future<void> getCurrentLocation(BuildContext context) async {
    try {
      // Her butona tıklandığında konum izinlerini kontrol et ve güncel konumu al
      isButtonDisabled.value = true;
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
        isButtonDisabled.value = false;
        if (permission == LocationPermission.denied) {
          isButtonDisabled.value = false;
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
      await _checkIfUserInsideCircle(context);
      print("$userLatitude ,, $userLongitude");
    } catch (e) {
      print('Konum alınamıyor: $e');
    }
  }

  Future<double> getDistance() async {
    double distance = Geolocator.distanceBetween(
      userLatitude,
      userLongitude,
      circleLatitude,
      circleLongitude,
    );
    return distance;
  }

  Future<void> _checkIfUserInsideCircle(BuildContext context) async {
    double distance = await getDistance();

    isInsideCircle.value = distance <= circleRadius;

    print("Konum Bilgisi: ${isInsideCircle.value}");
    if (isInsideCircle.value) {
      final snackBar = SnackbarContent("You are in location!",
          "The door is opening...", ContentType.success);

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      await gateAccess(isInside.value);
      isButtonDisabled.value = false;
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
        isButtonDisabled.value = false;
      });
    }
  }

  Future<void> gateAccess(bool isInside) async {
    try {
      if (isInside) {
        setGateAccessModel = GateAccessModel.fromAccess(await networkUtils
            .handleResponse(await networkUtils.buildHttpResponse(
                APIEndPoints.authEndpoints.exitGate,
                request: {},
                method: HttpMethod.PATCH)));
        this.isInside.value = gateAccessModel.value.isInside!;

        exitTime.value = gateAccessModel.value.entries!.last.exitTime!;
      } else {
        setGateAccessModel = GateAccessModel.fromAccess(await networkUtils
            .handleResponse(await networkUtils.buildHttpResponse(
                APIEndPoints.authEndpoints.openGate,
                request: {},
                method: HttpMethod.POST)));
        if (gateAccessModel.value.isInside != null) {
          this.isInside.value = gateAccessModel.value.isInside!;
        }

        if (gateAccessModel.value.entries!.last.exitTime == null) {
          exitTime.value = 'N/A';
        }
        entryTime.value = gateAccessModel.value.entries!.last.entryTime!;
      }

      print(gateAccessModel.value);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getLatestGateInfo() async {
    try {
      setGateAccessModel = GateAccessModel.fromInfo(await networkUtils
          .handleResponse(await networkUtils.buildHttpResponse(
              APIEndPoints.authEndpoints.latestGateInfo,
              method: HttpMethod.GET)));
      if (gateAccessModel.value.isInside != null) {
        isInside.value = gateAccessModel.value.isInside!;
      }

      if (gateAccessModel.value.lastEntry != null &&
          gateAccessModel.value.lastExit != null) {
        entryTime.value = gateAccessModel.value.lastEntry!;
        exitTime.value = gateAccessModel.value.lastExit!;
      } else if (gateAccessModel.value.lastEntry != null &&
          gateAccessModel.value.lastExit == null) {
        entryTime.value = gateAccessModel.value.lastEntry!;
      }
    } catch (e) {
      entryTime.value = "N/A";
      exitTime.value = "N/A";
      print("Veri gelmedi.");
    }
  }
}
