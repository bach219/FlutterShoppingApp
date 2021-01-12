import 'dart:async';
import 'dart:convert';
import 'package:fluttercommerce/models/models.dart';
import 'package:fluttercommerce/Repository/UserRepository/user_repository.dart';
import 'package:fluttercommerce/network/api.dart';

class ListRepository {
  Future<List<Product>> fetchListNew() async {
    print("productList");
    var data = await UserRepository().getToken();
    final response = await CallApi().postData(data, "productList");
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      print(
          body.length.toString() + " langthhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
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
          func: json['func_name'].toString(),
        );
      }).toList();
    }
    throw Exception('error fetching List Product');
  }

  Future<double> fetchBestExpensive() async {
    print("getBestExpensive");
    var data = await UserRepository().getToken();
    final response = await CallApi().postData(data, "getBestExpensive");
    if (response.statusCode == 200) {
      final body = double.parse(json.decode(response.body).toString());
      return body;
    }
    throw Exception('error fetching getBestExpensive');
  }

  Future<double> fetchCheapest() async {
    print("getCheapest");
    var data = await UserRepository().getToken();
    final response = await CallApi().postData(data, "getCheapest");
    if (response.statusCode == 200) {
      final body = double.parse(json.decode(response.body).toString());
      return body;
    }
    throw Exception('error fetching getCheapest');
  }
  
}
