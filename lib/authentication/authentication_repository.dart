import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:hive/hive.dart';
import 'package:fluttercommerce/network/api.dart';
import 'package:fluttercommerce/cart/models/item.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    @required String email,
    @required String password,
  }) async {
    assert(email != null);
    assert(password != null);
    var data = {'email': email, 'password': password};
    var res = await CallApi().postData(data, 'login');
    var body = json.decode(res.body);
    await Hive.openBox('Box');
    var box = Hive.box('Box');
    box.put('token', body['token'].toString());
    print(body['token']);
    box.put('client', json.encode(body['client']).toString());
    box.put('listItem', jsonEncode(<Item>[]).toString());
    // box.close();
    if (res.statusCode.toString() == '200')
      await Future.delayed(
        const Duration(milliseconds: 300),
        () => _controller.add(AuthenticationStatus.authenticated),
      );
    else
      throw Exception("Tài khoản chưa đúng!");
  }

  Future<void> signUp(
      {@required String email,
      @required String password,
      @required String passwordVerify,
      @required String address,
      @required String phone,
      @required String name,
      @required String sex}) async {
    assert(email != null);
    assert(password != null);
    assert(passwordVerify != null);
    assert(address != null);
    assert(phone != null);
    assert(name != null);
    assert(sex != null);

    var data = {
      'email': email,
      'password': password,
      'passwordVerify': passwordVerify,
      'address': address,
      'phone': phone,
      'name': name,
      'sex': sex,
    };
    var res = await CallApi().postData(data, 'signup');
    var body = json.decode(res.body);
    await Hive.openBox('Box');
    var box = Hive.box('Box');
    box.put('token', body['token'].toString());
    box.put('client', json.encode(body['client']).toString());
    box.put('listItem', jsonEncode(<Item>[]).toString());
    if (res.statusCode.toString() == '200')
      await Future.delayed(
        const Duration(milliseconds: 300),
        () => _controller.add(AuthenticationStatus.authenticated),
      );
    else
      throw Exception("Thông tin có lẽ đã được đăng ký!");
  }

  Future<void> logOut() async {
    await Hive.openBox('Box');
    var box = Hive.box('Box');
    String token = box.get('token');
    print(token);
    await CallApi().logOut(token);
    box.deleteFromDisk();
    // box.delete("listItem");
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
