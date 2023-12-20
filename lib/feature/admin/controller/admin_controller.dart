import 'package:gate_pass_management/feature/admin/model/users_model2.dart';
import 'package:get/get.dart';
import '../../../network/NetworkUtils.dart';
import '../../../product/constant/constants.dart';
import '../../door-management/models/gate_access_model.dart';

class AdminController extends GetxController with StateMixin {
  RxList<UserModel2> unapprovedAccounts = RxList<UserModel2>([]);
  RxList<UserModel2> allapprovedAccounts = RxList<UserModel2>([]);
  RxList<UserModel2> allBlockedAccounts = RxList<UserModel2>([]);
  NetworkUtils networkUtils = NetworkUtils();
  final accepted = Rxn<bool>();
  RxBool isLoadingData = false.obs;

  final Map<String, List<Entry>> allEntryHistory = {};
  final Map<String, List<Entry>> allExitHistory = {};
  Rx<GateAccessModel> gateAccessModel = GateAccessModel().obs;
  set setGateAccessModel(GateAccessModel value) =>
      gateAccessModel.value = value;

  RxList<GateAccessModel> gateAccessList = <GateAccessModel>[].obs;

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
        } else {
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
            .where((user) =>
                (user.isApproved == true || user.isApproved == false) &&
                user.isBlocked == true)
            .toList();
        isLoadingData.value = false;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAllLatestGateInfo() async {
    try {
      isLoadingData.value = true;
      List<dynamic> jsonData = await networkUtils.handleResponse(
          await networkUtils.buildHttpResponse(
              APIEndPoints.authEndpoints.latestAllGateInfo,
              method: HttpMethod.GET));
      List<Map<String, dynamic>> jsonList =
          jsonData.cast<Map<String, dynamic>>().toList();
      gateAccessList.value =
          jsonList.map((json) => GateAccessModel.fromAllInfo(json)).toList();
      // Eğer kullanıcı daha önce eklenmediyse, yeni bir listeyi başlat
      gateAccessList.forEach((gateAccess) {
        String id = gateAccess.username!;

        // Eğer kullanıcı daha önce eklenmediyse, yeni bir listeyi başlat
        if (!allEntryHistory.containsKey(id)) {
          allEntryHistory[id] = [];
          gateAccess.entries?.reversed.forEach((entry) {
            allEntryHistory[id]!.add(entry);
          });
        }
        if (!allExitHistory.containsKey(id)) {
          allExitHistory[id] = [];
          gateAccess.entries?.reversed.forEach((entry) {
            if (entry.exitDate != null && entry.exitTime != null) {
              allExitHistory[id]!.add(entry);
            }
          });
        }

        // Kullanıcının giriş ve çıkış verilerini ilgili listelere ekle
      });
      isLoadingData.value = false;
    } catch (e) {
      print("Hata oluştu: $e");
    }
  }
}
