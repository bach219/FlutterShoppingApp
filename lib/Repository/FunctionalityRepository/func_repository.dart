import 'dart:async';
import 'dart:convert';
import 'package:fluttercommerce/models/models.dart';
import 'package:fluttercommerce/Repository/UserRepository/user_repository.dart';
import 'package:fluttercommerce/network/api.dart';

class FunctionalityRepository {
  Future<List<Functionality>> fetchListFunction() async {
    print("getFunctionality");
    var data = await UserRepository().getToken();
    final response = await CallApi().postData(data, "getFunctionality");
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return Functionality(
          id: json['func_id'].toString(),
          name: json['func_name'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching list function');
  }
}
