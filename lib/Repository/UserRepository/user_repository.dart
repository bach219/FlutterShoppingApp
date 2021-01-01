import 'dart:async';
import 'dart:convert';
import 'package:hive/hive.dart';

import 'package:fluttercommerce/models/models.dart';

class UserRepository {
  // User _user;

  Future<User> getUser() async {
    await Hive.openBox('Box');
    var box = Hive.box('Box');
    String client = box.get('client');
    print(client);
    var user = json.decode(client.toString());
    User u = User(
      email: user['email'].toString(),
      id: user['id'].toString(),
      name: user['name'].toString(),
      sex: user['sex'].toString(),
      phone: user['phone'].toString(),
      address: user['address'].toString(),
      photo: user['image'].toString(),
    );
    return u;
  }

  Future<Map<String, String>> getToken() async {
    await Hive.openBox('Box');
    var box = Hive.box('Box');
    var token = box.get('token');
    return {'token': token};
  }
}
