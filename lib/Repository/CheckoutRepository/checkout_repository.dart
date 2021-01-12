import 'dart:async';
import 'dart:convert';
import 'package:fluttercommerce/models/models.dart';
import 'package:fluttercommerce/Repository/repository.dart';
import 'package:fluttercommerce/network/api.dart';
import 'package:fluttercommerce/cart/models/models.dart';

class CheckOutRepository {
  Future<bool> postCheckOut(String note) async {
    print("postCheckOut");
    var data = await UserRepository().getToken();
    List<Item> items = await ItemRepository().getListItem();
    String id = items.map((e) => e.id.trim()).join(',');
    String price = items
        .map((e) => (e.price * (1 - e.sale / 100)).toString().trim())
        .join(',');
    String qty = items.map((e) => e.qty.toString().trim()).join(',');
    double total = items.fold(
        0,
        (total, current) =>
            total + current.price * (1 - current.sale / 100) * current.qty);

    Map<String, String> map = {
      "id": id,
      "price": price,
      "qty": qty,
      "total": total.toString(),
      "note": note
    };
    map.addAll(data);
    final response = await CallApi().postData(map, "postCheckOut");
    if (response.statusCode == 200) return true;
    return false;
  }
}
