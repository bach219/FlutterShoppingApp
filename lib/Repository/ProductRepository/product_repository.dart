import 'dart:async';
import 'dart:convert';
import 'package:fluttercommerce/Repository/UserRepository/user_repository.dart';
import 'package:fluttercommerce/models/models.dart';
import 'package:fluttercommerce/network/api.dart';

class ProductRepository {
  // User _user;

  // ignore: missing_return
  Future<List<Product>> getlistSearch(String search) async {
    print("getSearch");
    var data = await UserRepository().getToken();
    Map<String, String> map = {'search': search};
    map.addAll(data);
    final response = await CallApi().postData(map, "getSearch");
    try {
      if (response.statusCode == 200) {
        final body = json.decode(response.body) as List;
        if (body.length > 1)
          return body.map((dynamic json) {
            return Product(
              id: json['prod_id'].toString(),
              company: json['cate_name'] as String,
              name: json['prod_name'] as String,
              icon: json['prod_img'] as String,
              rating: 5.0,
              price: double.parse(json['prod_price'].toString()),
              remainingQuantity: json['prod_qty'] as int,
              description: json['prod_name'] as String,
              sale: double.parse(json['prod_sale'].toString()),
            );
          }).toList();
        else if (body.isEmpty) {
          return null;
        } else {
          List<Product> list = [];
          Product product = Product(
            id: body[0]['prod_id'].toString(),
            company: body[0]['cate_name'] as String,
            name: body[0]['prod_name'] as String,
            icon: body[0]['prod_img'] as String,
            rating: 5.0,
            price: double.parse(body[0]['prod_price'].toString()),
            remainingQuantity: body[0]['prod_qty'] as int,
            description: body[0]['prod_name'] as String,
            sale: double.parse(body[0]['prod_sale'].toString()),
          );
          list.add(product);
          return list;
        }
      }
    } on Exception catch (_) {
      return null;
    }
    return null;
  }
}
