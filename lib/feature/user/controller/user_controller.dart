import 'package:flutter/widgets.dart';
import 'package:gate_pass_management/network/networkUtils.dart';
import 'package:get/get.dart';

import '../../../product/constant/constants.dart';
import '../../door-management/models/gate_access_model.dart';

class UserController extends GetxController with StateMixin {
  late RxList<Entry>? entryHistory;
  late RxList<Entry>? exitHistory;
  NetworkUtils networkUtils = NetworkUtils();
  Rx<GateAccessModel> gateAccessModel = GateAccessModel().obs;
  set setGateAccessModel(GateAccessModel value) =>
      gateAccessModel.value = value;
  RxInt currentPage = RxInt(0);

  @override
  void onInit() async {
    entryHistory = RxList<Entry>();
    exitHistory = RxList<Entry>();
    change(null, status: RxStatus.loading());
    await getLatestGateInfo();
    change(null, status: RxStatus.success());
    super.onInit();
  }

  Future<void> getLatestGateInfo() async {
    try {
      setGateAccessModel = GateAccessModel.fromInfo(await networkUtils
          .handleResponse(await networkUtils.buildHttpResponse(
              APIEndPoints.authEndpoints.latestGateInfo,
              method: HttpMethod.GET)));
      for (var entry in gateAccessModel.value.entries!.reversed) {
        entryHistory?.add(entry);
        if (entry.exitDate != null && entry.exitTime != null) {
          exitHistory?.add(entry);
        }
      }
      exitHistory?.forEach((element) {
        print(element.exitTime);
      });
      print(exitHistory?.length);
    } catch (e) {
      print("Hata oluştu: $e");
    }
  }
}
