import 'package:flutter/material.dart';
import 'package:gate_pass_management/product/constant/constants.dart';
import 'package:get/get.dart' hide ContextExtensionss;
import 'package:get_storage/get_storage.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    Future.delayed(const Duration(seconds: 2)).then((value) {
    if (box.read(GetStorageKeys.IS_LOGGED_IN) == true) {
      Get.offAllNamed('/mainwrapper');
    } else {
      Get.offAllNamed('/login');
    }
    });
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.height(),
        width: context.width(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Image.asset('images/qr-menu.png', height: 150, width: 150),
            16.height,
            Text("ParkEasy", style: boldTextStyle(size: 24)),
          ],
        ),
      ).center(),
    );
  }
}
