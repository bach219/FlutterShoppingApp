import 'dart:async';
import 'dart:convert';
import 'package:hive/hive.dart';

import '../models/models.dart';

class UserRepository {
  // User _user;

  Future<User> getUser() async {
    await Hive.openBox('Box');
    var box = Hive.box('Box');
    String client = box.get('client');
    box.close();
    print(client);
    var user = json.decode(client.toString());
    User u = User(
        email: user['email'].toString(),
        id: user['id'].toString(),
        name: user['name'].toString(),
        sex: user['sex'].toString(),
        phone: user['phone'].toString(),
        address: user['address'].toString());
    return u;
  }

  Future<String> getToken() async {
    await Hive.openBox('Box');
    var box = Hive.box('Box');
    var token = box.get('token');
    box.close();
    return token.toString();
    // box.close();
  }
}
