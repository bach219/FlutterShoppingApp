import 'package:flutter/material.dart';

import 'package:fluttercommerce/authentication/authentication.dart';
import 'package:hive/hive.dart';
import 'package:fluttercommerce/Repository/UserRepository/user_repository.dart';
import 'package:fluttercommerce/app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);
  await Hive.openBox('Box');

  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}
