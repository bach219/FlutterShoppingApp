import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../view/info_view/info_page.dart';
import 'package:flutter_icons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttercommerce/account/view/info_view/info_view.dart';
import '../view/repass_view/repass_page.dart';

class AccountSettings extends StatefulWidget {
  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  final StyleClass settingsItemIconStyle = StyleClass()
    ..padding(all: 8)
    ..borderRadius(all: 30);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cài đặt tài khoản",
          style: TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 18),
        ),
        leading: IconButton(
          icon:
              Icon(Ionicons.getIconData("ios-arrow-back"), color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Color(0xFFDBCC8F),
      ),
      body: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: InfoPage(),
                    ),
                  );
                },
                child: Container(
                  child: Card(
                    child: ListTile(
                      title: Text(
                        "Thông tin cá nhân",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7), fontSize: 18),
                      ),
                      leading: Division(
                        style: StyleClass()
                          ..backgroundColor("#FDB78B")
                          ..add(settingsItemIconStyle),
                        child: Icon(
                          Feather.getIconData("user"),
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    elevation: 1,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: RepassPage(),
                    ),
                  );
                },
                child: Container(
                  child: Card(
                    child: ListTile(
                      title: Text(
                        "Thay đổi mật khẩu",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7), fontSize: 18),
                      ),
                      leading: Division(
                        style: StyleClass()
                          ..backgroundColor("#24ACE9")
                          ..add(settingsItemIconStyle),
                        child: Icon(
                          Feather.getIconData("lock"),
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    elevation: 1,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                child: Container(
                  child: Card(
                    child: ListTile(
                      title: Text(
                        "Thoát ứng dụng",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7), fontSize: 18),
                      ),
                      leading: Division(
                        style: StyleClass()
                          ..backgroundColor("#FB7C7A")
                          ..add(settingsItemIconStyle),
                        child: Icon(
                          Feather.getIconData("log-out"),
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    elevation: 1,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
