import 'dart:convert';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import '../product/constant/constants.dart';
import 'package:http/http.dart';

class NetworkUtils {
  final box = GetStorage();
  Map<String, String> buildHeaderTokens() {
    Map<String, String> header = {};

    header.putIfAbsent(
        HttpHeaders.contentTypeHeader, () => 'application/json; charset=utf-8');
    header.putIfAbsent(
        HttpHeaders.authorizationHeader, () => 'Bearer ${box.read('token')}');
    header.putIfAbsent(
        HttpHeaders.acceptHeader, () => 'application/json; charset=utf-8');

    print(jsonEncode(header));
    return header;
  }

  Uri buildBaseUrl(String endPoint) {
    Uri url = Uri.parse(endPoint);
    if (!endPoint.startsWith('http'))
      url = Uri.parse('${APIEndPoints.baseUrl}$endPoint');

    print('URL: ${url.toString()}');

    return url;
  }

  Future<Response> buildHttpResponse(String endPoint,
      {HttpMethod method = HttpMethod.GET, Map? request}) async {
    if (await isNetworkAvailable()) {
      var headers = buildHeaderTokens();
      Uri url = buildBaseUrl(endPoint);

      Response response;

      if (method == HttpMethod.POST) {
        response = await http.post(url,
            body: jsonEncode(request), headers: headers, encoding: null);
      } else if (method == HttpMethod.DELETE) {
        response = await delete(url, headers: headers);
      } else if (method == HttpMethod.PUT) {
        response = await put(url, body: jsonEncode(request), headers: headers);
      } else {
        response = await get(url, headers: headers);
      }

      print('Response ($method): ${response.statusCode} ${response.body}');

      return response;
    } else {
      throw ();
    }
  }

  Future handleResponse(Response response, [bool? avoidTokenError]) async {
    if (!await isNetworkAvailable()) {
      throw errorInternetNotAvailable;
    }
    if (response.statusCode == 401) {
      if (!avoidTokenError.validate()) box.remove("token");
      throw 'Token Expired';
    }

    if (response.statusCode.isSuccessful()) {
      var json = jsonDecode(response.body);
      var token = json['data']['Token'];
      await box.write('token', token);
      return json;
    } else {
      try {
        var body = jsonDecode(response.body);
        throw body['message'];
      } on Exception catch (e) {
        print(e);
        throw errorSomethingWentWrong;
      }
    }
  }
}

enum HttpMethod { GET, POST, DELETE, PUT }
