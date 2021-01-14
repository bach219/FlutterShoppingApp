import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import './account_setting.dart';
import 'package:fluttercommerce/screens/checkout.dart';
import 'package:page_transition/page_transition.dart';

// ignore: must_be_immutable
class Account extends StatelessWidget {
  bool showAppBar = true;
  Account(this.showAppBar);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
        title: Text(
          "Tài khoản cá nhân",
          style: TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 18),
        ),
        leading: IconButton(
          icon:
              Icon(Ionicons.getIconData("ios-arrow-back"), color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Color(0xFFDBCC8F),
      ): null,
      body: SafeArea(child: UserSettingsState()),
    );
  }
}

class UserSettingsState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double verticalMargin = 0;
    return SingleChildScrollView(
      child: Division(
        style: StyleClass()
          ..margin(vertical: verticalMargin, horizontal: 20)
          ..minHeight(
              MediaQuery.of(context).size.height - (2 * verticalMargin)),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Settings(),
            ),
          ],
        ),
      ),
    );
  }
}

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Division(
      style: settingsStyle,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print("Tiklandi");
            },
            child: SettingsItem(Feather.getIconData("briefcase"), '#9F6083',
                'Đơn hàng', 'Xem lịch sử mua hàng.', () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: Checkout(),
                ),
              );
            }),
          ),
          SettingsItem(Feather.getIconData("settings"), '#FDB78B',
              'Cài đặt tài khoản', 'Chỉnh sửa thông tin cá nhân.', () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: AccountSettings(),
              ),
            );
          }),
          // SettingsItem(
          //     Feather.getIconData("tag"),
          //     '#57CFE2',
          //     'Discount coupons',
          //     'Coupons you want to use for your shopping.', () {
          //   Navigator.push(
          //     context,
          //     PageTransition(
          //       type: PageTransitionType.fade,
          //       child: Checkout(),
          //     ),
          //   );
          // }),
          // SettingsItem(Feather.getIconData("message-circle"), '#606B7E',
          //     'My Comments', 'Your comments for products', () {
          //   Navigator.push(
          //     context,
          //     PageTransition(
          //       type: PageTransitionType.fade,
          //       child: Checkout(),
          //     ),
          //   );
          // }),
          SettingsItem(Feather.getIconData("bell"), '#FB7C7A', 'Thông báo',
              'Những chương trình mói nhất.', () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: Checkout(),
              ),
            );
          }),
          SettingsItem(Feather.getIconData("help-circle"), '#24ACE9',
              'Trợ giúp', 'Liên hệ với chúng tôi.', () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: Checkout(),
              ),
            );
          }),
        ],
      ),
    );
  }

  final StyleClass settingsStyle = StyleClass();
}

class SettingsItem extends StatefulWidget {
  final IconData icon;
  final String iconBgColor;
  final String title;
  final String description;
  final Function touchItem;

  SettingsItem(this.icon, this.iconBgColor, this.title, this.description,
      this.touchItem);

  @override
  _SettingsItemState createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Division(
        style: settingsItemStyle
          ..elevation(pressed ? 0 : 50, color: Colors.grey)
          ..scale(pressed ? 0.95 : 1.0),
        gesture: GestureClass()
          ..onTap(widget.touchItem)
          ..onTapDown((details) => setState(() => pressed = true))
          ..onTapUp((details) => setState(() => pressed = false))
          ..onTapCancel(() => setState(() => pressed = false)),
        child: Row(
          children: <Widget>[
            Division(
              style: StyleClass()
                ..backgroundColor(widget.iconBgColor)
                ..add(settingsItemIconStyle),
              child: Icon(
                widget.icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.title,
                  style: itemTitleTextStyle,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  widget.description,
                  style: itemDescriptionTextStyle,
                ),
              ],
            )
          ],
        ));
  }

  final StyleClass settingsItemStyle = StyleClass()
    ..alignChild('center')
    ..height(70)
    ..margin(vertical: 10)
    ..borderRadius(all: 15)
    ..backgroundColor('#ffffff')
    ..ripple(true)
    ..animate(300, Curves.easeOut);

  final StyleClass settingsItemIconStyle = StyleClass()
    ..margin(left: 15)
    ..padding(all: 12)
    ..borderRadius(all: 30);

  final TextStyle itemTitleTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

  final TextStyle itemDescriptionTextStyle = TextStyle(
      color: Colors.black26, fontWeight: FontWeight.bold, fontSize: 12);
}
