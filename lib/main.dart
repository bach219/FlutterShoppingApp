import 'package:flutter/material.dart';

import 'package:fluttercommerce/authentication/authentication.dart';
import 'package:hive/hive.dart';
import 'package:fluttercommerce/Repository/UserRepository/user_repository.dart';
import 'package:fluttercommerce/app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  // await Hive.initFlutter();
  // await Hive.openBox('Box');
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);
  await Hive.openBox('Box');
  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}
// class EcommerceApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         theme: ThemeData(
//           dividerColor: Color(0xFFECEDF1),
//           brightness: Brightness.light,
//           backgroundColor: Colors.white,
//           primaryColor: Color(0xFFF93963),
//           accentColor: Colors.cyan[600],
//           fontFamily: 'Montserrat',
//           textTheme: TextTheme(
//             headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
//             title: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
//             subtitle: TextStyle(fontSize: 16),
//             body1: TextStyle(fontSize: 14.0, fontFamily: 'Montserrat'),
//             display1: TextStyle(
//                 fontSize: 14.0, fontFamily: 'Montserrat1', color: Colors.white),
//             display2: TextStyle(
//                 fontSize: 14.0,
//                 fontFamily: 'Montserrat',
//                 color: Colors.black54),
//           ),
//         ),
//         debugShowCheckedModeBanner: false,
//         title: 'Bach\'s Shop',
//         home: (App(
//                 authenticationRepository: AuthenticationRepository(),
//                 userRepository: UserRepository())
//             // routes: {
//             //   '/product': (context) => ProductPage(),
//             // },
//             ));
//   }
// }

// class TabLayoutDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       color: Colors.yellow,
//       home: DefaultTabController(
//         length: 4,
//         child: new Scaffold(
//           body: TabBarView(
//             children: [
//               new Container(
//                 color: Colors.yellow,
//               ),
//               new Container(
//                 color: Colors.orange,
//               ),
//               new Container(
//                 color: Colors.lightGreen,
//               ),
//               new Container(
//                 color: Colors.red,
//               ),
//             ],
//           ),
//           bottomNavigationBar: new TabBar(
//             tabs: [
//               Tab(
//                 icon: new Icon(Icons.home),
//               ),
//               Tab(
//                 icon: new Icon(Icons.rss_feed),
//               ),
//               Tab(
//                 icon: new Icon(Icons.perm_identity),
//               ),
//               Tab(
//                 icon: new Icon(Icons.settings),
//               )
//             ],
//             labelColor: Colors.yellow,
//             unselectedLabelColor: Colors.blue,
//             indicatorSize: TabBarIndicatorSize.label,
//             indicatorPadding: EdgeInsets.all(5.0),
//             indicatorColor: Colors.red,
//           ),
//           backgroundColor: Colors.black,
//         ),
//       ),
//     );
//   }
// }
