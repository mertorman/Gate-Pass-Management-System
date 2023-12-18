import 'dart:convert';

import 'package:gate_pass_management/feature/admin/model/users_model2.dart';
import 'package:gate_pass_management/feature/auth/login-signup/models/user_Model.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../network/NetworkUtils.dart';
import '../../../product/constant/constants.dart';

class AdminController extends GetxController with StateMixin {
  RxList<UserModel2> unapprovedAccounts = RxList<UserModel2>([]);
  RxList<UserModel2> allapprovedAccounts = RxList<UserModel2>([]);
  RxList<UserModel2> allBlockedAccounts = RxList<UserModel2>([]);
  NetworkUtils networkUtils = NetworkUtils();
  final accepted = Rxn<bool>();
  RxBool isLoadingData = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await unapprovedGetAccounts();
  }

  Future<void> unapprovedGetAccounts() async {
    try {
      change(null, status: RxStatus.loading());
      var response = await networkUtils.handleResponse(await networkUtils
          .buildHttpResponse(APIEndPoints.authEndpoints.getUsers,
              method: HttpMethod.GET));
      if (response is List<dynamic>) {
        unapprovedAccounts.value = response
            .map((e) => UserModel2.fromJson(e))
            .where(
                (user) => user.isApproved == false && user.isBlocked == false)
            .toList();
        print(unapprovedAccounts.value.length);
        change(null, status: RxStatus.success());
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> confirmAccount(String id) async {
    try {
      await networkUtils
          .handleResponse(await networkUtils.buildHttpResponse(
              APIEndPoints.authEndpoints.confirmAccount + id,
              request: {"isApproved": true},
              method: HttpMethod.PATCH))
          .then((value) async {
        await Future.delayed(Duration(milliseconds: 200));
        unapprovedAccounts.value.removeWhere((element) => element.id == id);
        unapprovedAccounts.refresh();
      });

      print(unapprovedAccounts.value.length);
    } catch (e) {
      print(e);
    }
  }

  Future<void> rejectAccount(String id, bool unapprovedAcoounts) async {
    try {
      await networkUtils
          .handleResponse(await networkUtils.buildHttpResponse(
              APIEndPoints.authEndpoints.rejectAccount + id,
              request: {"isBlocked": true},
              method: HttpMethod.PATCH))
          .then((value) async {
        await Future.delayed(Duration(milliseconds: 200));
        if (unapprovedAcoounts) {
          unapprovedAccounts.value.removeWhere((element) => element.id == id);
          unapprovedAccounts.refresh();
        }else{
        allapprovedAccounts.value.removeWhere((element) => element.id == id);
        allapprovedAccounts.refresh();
        }
      });

      print(unapprovedAccounts.value.length);
    } catch (e) {
      print(e);
    }
  }

    Future<void> unBlockedAccount(String id) async {
    try {
      await networkUtils
          .handleResponse(await networkUtils.buildHttpResponse(
              APIEndPoints.authEndpoints.rejectAccount + id,
              request: {"isBlocked": false},
              method: HttpMethod.PATCH))
          .then((value) async {
        await Future.delayed(Duration(milliseconds: 200));
          allBlockedAccounts.value.removeWhere((element) => element.id == id);
          allBlockedAccounts.refresh();
      });

     // print(unapprovedAccounts.value.length);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAllAprovedAccounts() async {
    try {
      isLoadingData.value = true;
      var response = await networkUtils.handleResponse(await networkUtils
          .buildHttpResponse(APIEndPoints.authEndpoints.getAllApprovedAccounts,
              method: HttpMethod.GET));
      if (response is List<dynamic>) {
        allapprovedAccounts.value = response
            .map((e) => UserModel2.fromJson(e))
            .where((user) => user.isApproved == true && user.isBlocked == false)
            .toList();
        isLoadingData.value = false;
      }
    } catch (e) {
      print(e);
    }
  }

    Future<void> getAllBlockedAccounts() async {
    try {
      isLoadingData.value = true;
      var response = await networkUtils.handleResponse(await networkUtils
          .buildHttpResponse(APIEndPoints.authEndpoints.getAllApprovedAccounts,
              method: HttpMethod.GET));
      if (response is List<dynamic>) {
        allBlockedAccounts.value = response
            .map((e) => UserModel2.fromJson(e))
            .where((user) => (user.isApproved == true || user.isApproved == false) && user.isBlocked == true)
            .toList();
        isLoadingData.value = false;
      }
    } catch (e) {
      print(e);
    }
  }
}
