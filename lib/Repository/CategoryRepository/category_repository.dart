import 'dart:async';
import 'dart:convert';
import 'package:fluttercommerce/models/models.dart';
import 'package:fluttercommerce/Repository/UserRepository/user_repository.dart';
import 'package:fluttercommerce/network/api.dart';

class CategoryRepository {
  Future<List<Category>> fetchListCategory() async {
    print("getCategory");
    var data = await UserRepository().getToken();
    final response = await CallApi().postData(data, "getCategory");
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return Category(
          id: json['cate_id'].toString(),
          name: json['cate_name'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching list function');
  }
}
