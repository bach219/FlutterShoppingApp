import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class CallApi {
  final String _url = 'http://192.168.100.18/AppStore/public/api/';

  // ignore: lines_longer_than_80_chars
  Future<http.Response> postData(
      Map<String, String> data, String apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

  Future<http.Response> getData(Map<String, String> data, String apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.get(fullUrl, headers: _setHeaders());
  }

  Future<http.Response> logOut(String token) async {
    var fullUrl = _url + "logout";
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    return await http.post(fullUrl, headers: headers);
  }

  Map<String, String> _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
}
