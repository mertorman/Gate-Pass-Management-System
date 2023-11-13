import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:nb_utils/nb_utils.dart';
import '../product/constant/constants.dart';
import 'package:dio/dio.dart';

class NetworkUtils {
  static var box = GetStorage();

  final dio = Dio(BaseOptions(
    baseUrl: APIEndPoints.baseUrl,
    connectTimeout: const Duration(milliseconds: 6000),
    receiveTimeout: const Duration(milliseconds: 6000),
    contentType: 'application/json; charset=utf-8'
  ));

  NetworkUtils() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers["Accept"] = "application/json";
        String? token = box.read("accessToken");
        options.headers["Authorization"] = 'Bearer $token';
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          final newAccessToken = await refreshToken();
          if (newAccessToken != null) {
            dio.options.headers["Authorization"] = 'Bearer $newAccessToken';
            return handler.resolve(await dio.fetch(error.requestOptions));
          }
        }
        return handler.next(error);
      },
    ));
  }

  Future<String?> refreshToken() async {
    try {
      final refreshToken = box.read("refreshToken");
      final response = await dio
          .post('auth/refresh-tokens/', data: {'refreshToken': refreshToken});
      print(response.data['access']['token']);
      final newAccessToken = response.data['access']['token'];
      final newRefreshToken = response.data['refresh']['token'];
      await box.write('accessToken', newAccessToken);
      await box.write('refreshToken', newRefreshToken);
      return newAccessToken;
    } catch (e) {
      box.erase();
      Get.offAllNamed('/login');
    }
    return null;
  }

/*
  static Map<String, dynamic> buildHeaderTokens() {
    Map<String, String> header = {};

    header.putIfAbsent(
        HttpHeaders.contentTypeHeader, () => 'application/json; charset=utf-8');
    header.putIfAbsent(HttpHeaders.authorizationHeader,
        () => 'Bearer ${box.read('accessToken')}');
    header.putIfAbsent(
        HttpHeaders.acceptHeader, () => 'application/json; charset=utf-8');

    print(jsonEncode(header));
    return header;
  }*/

  Future<Response> buildHttpResponse(String endPoint,
      {HttpMethod method = HttpMethod.GET, Map? request}) async {
    if (await isNetworkAvailable()) {
      //var headers = buildHeaderTokens();
      //Uri url = buildBaseUrl(endPoint);

      Response response;

      if (method == HttpMethod.POST) {
        response = await dio.post(endPoint, data: jsonEncode(request));
      } else if (method == HttpMethod.DELETE) {
        response = await dio.delete(endPoint, data: jsonEncode(request));
      } else if (method == HttpMethod.PUT) {
        response = await dio.put(endPoint, data: jsonEncode(request));
      } else if(method == HttpMethod.PATCH){
        response = await dio.patch(endPoint, data: jsonEncode(request));
      } else {
        response = await dio.get(endPoint);
      }

      print('Response ($method): ${response.statusCode} ${response.data}');

      return response;
    } else {
      throw ();
    }
  }

  Future handleResponse(Response response) async {
    if (!await isNetworkAvailable()) {
      throw errorInternetNotAvailable;
    }
    if (response.statusCode.isSuccessful()) {
      var json = response.data;

      // var token = json['data']['Token'];
      // await box.write('token', token);
      return json;
    } else {
      try {
        var body = response.data;
        throw body['message'];
      } on Exception catch (e) {
        print(e);
        throw errorSomethingWentWrong;
      }
    }
  }
}

enum HttpMethod { GET, POST, DELETE, PUT, PATCH }
