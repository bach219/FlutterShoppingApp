import 'dart:async';
import 'dart:convert';
import 'package:fluttercommerce/Repository/UserRepository/user_repository.dart';
import 'package:fluttercommerce/network/api.dart';

import 'package:meta/meta.dart';
import 'package:hive/hive.dart';

class AccountRepository {
  Future<bool> postClient(
      {@required String email,
      @required String address,
      @required String phone,
      @required String name,
      @required String sex}) async {
    assert(email != null);
    assert(address != null);
    assert(phone != null);
    assert(name != null);
    assert(sex != null);
    print("postClient");
    var data = {
      'email': email,
      'address': address,
      'phone': phone,
      'name': name,
      'sex': sex,
    };
    var res = await CallApi().postData(data, 'postAccount');
    if (res.statusCode == 200) {
      getClient();
      return true;
    }
    return false;
  }

  Future<void> getClient() async {
    var data = await UserRepository().getToken();
    var res = await CallApi().postData(data, 'client');
    if (res.statusCode == 200) {
      var body = json.decode(res.body);
      await Hive.openBox('Box');
      var box = Hive.box('Box');
      box.put('client', json.encode(body['client']).toString());
    } else
      throw Exception("Có gì đó chưa đúng!");
  }

  Future<bool> rePass({
    @required String oldPass,
    @required String newPass,
    @required String rePass,
  }) async {
    assert(oldPass != null);
    assert(oldPass != null);
    assert(rePass != null);
    print("postClient");
    var data = {
      'oldpass': oldPass,
      'newpass': newPass,
      'repass': rePass,
    };
    var res = await CallApi().postData(data, 'postPass');
    if (res.statusCode == 200) 
      return true;
    return false;
  }
}
