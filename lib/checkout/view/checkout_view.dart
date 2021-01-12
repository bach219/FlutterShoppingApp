import 'package:flutter/material.dart';
import 'package:flutter_icons/ionicons.dart';
import 'package:fluttercommerce/home/view/home_view/home_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:hive/hive.dart';
import 'dart:convert';
import 'package:fluttercommerce/checkout/bloc/checkout_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/cart/models/models.dart';
import 'package:fluttercommerce/Repository/repository.dart';
import 'package:fluttercommerce/cart/bloc/cart.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  TextEditingController _textController = TextEditingController();
  String get _note => _textController.text;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckOutBloc, CheckOutState>(
        // ignore: missing_return
        builder: (context, state) {
      switch (state.status) {
        case CheckOutStatus.initial:
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Checkout",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              leading: IconButton(
                icon: Icon(Ionicons.getIconData("ios-arrow-back"),
                    color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              backgroundColor: Color(0xFFDBCC8F),
            ),
            body: Center(
              child: Container(
                padding: EdgeInsets.only(
                    top: 12.0, left: 12.0, right: 12.0, bottom: 12.0),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 6.0,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Địa chỉ giao hàng"),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 12.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              color: Color(0xFFE7F9F5),
                              border: Border.all(
                                color: Color(0xFF4CD7A5),
                              ),
                            ),
                            child: ListTile(
                              trailing: Icon(
                                Icons.check_circle,
                                color: Color(0xFF10CA88),
                              ),
                              title: Text(state.client.address ?? ""),
                              // subtitle: Text("125 Lorem Ipsum"),
                            ),
                          ),
                          Text("Địa chỉ Email"),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 12.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              color: Color(0xFFE7F9F5),
                              border: Border.all(
                                color: Color(0xFF4CD7A5),
                              ),
                            ),
                            child: ListTile(
                              trailing: Icon(
                                Icons.check_circle,
                                color: Color(0xFF10CA88),
                              ),
                              leading: Icon(
                                Icons.email,
                                color: Color(0xFF10CA88),
                              ),
                              title: Text(state.client.email ?? ""),
                            ),
                          ),
                          Text("Số điện thoại"),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 12.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              color: Color(0xFFE7F9F5),
                              border: Border.all(
                                color: Color(0xFF4CD7A5),
                              ),
                            ),
                            child: ListTile(
                              trailing: Icon(
                                Icons.check_circle,
                                color: Color(0xFF10CA88),
                              ),
                              leading: Icon(
                                Icons.phone,
                                color: Color(0xFF10CA88),
                              ),
                              title: Text(state.client.phone ?? ""),
                            ),
                          ),
                          Text("Ghi chú"),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 12.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              color: Color(0xFFE7F9F5),
                              border: Border.all(
                                color: Color(0xFF4CD7A5),
                              ),
                            ),
                            child: TextField(
                              controller: _textController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.text,
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: 'Ghi chú khi giao hàng',
                                hintStyle: TextStyle(fontSize: 16),
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.note,
                                  color: Color(0xFF10CA88),
                                ),
                                suffixIcon: Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF10CA88),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 24.0),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              color: Color(0xFFF93963),
                              onPressed: () async {
                                var post = await CheckOutRepository()
                                    .postCheckOut(_note);
                                if (post) {
                                  await Hive.openBox('Box');
                                  var box = Hive.box('Box');
                                  box.put('listItem',
                                      jsonEncode(<Item>[]).toString());
                                  context.read<CartBloc>().add(CartStarted());
                                  showDialog(
                                    context: context,
                                    // ignore: deprecated_member_use
                                    child: AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16.0))),
                                      content: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.8,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.check_circle_outline,
                                              size: 96,
                                              color: Color(0xFF10CA88),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16.0),
                                              child: Text(
                                                "Đặt hàng thành công",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16.0),
                                              child: Text(
                                                "Cửa hàng sẽ sớm liên lạc với bạn",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                            FlatButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                              ),
                                              color: Color(0xFFDBCC8F),
                                              onPressed: () => {},
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 15.0,
                                                  horizontal: 10.0,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () async {
                                                          // Nav.route(
                                                          //     context, HomePage());
                                                          Navigator.push(
                                                            context,
                                                            PageTransition(
                                                              type:
                                                                  PageTransitionType
                                                                      .fade,
                                                              child: HomePage(),
                                                            ),
                                                          );

                                                          Navigator.of(context,
                                                                  rootNavigator:
                                                                      true)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                          "Tiếp tục mua sắm",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            FlatButton(
                                              child: Text("Đơn hàng đã mua"),
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    // ignore: deprecated_member_use
                                    child: AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16.0))),
                                      content: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.8,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.sms_failed_outlined,
                                              size: 96,
                                              color: Colors.red,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16.0),
                                              child: Text(
                                                "Đặt hàng thất bại",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16.0),
                                              child: Text(
                                                "Có điều gì đó đã xảy ra",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                            FlatButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                              ),
                                              color: Color(0xFFDBCC8F),
                                              onPressed: () => {},
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 15.0,
                                                  horizontal: 10.0,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () async {
                                                          // Nav.route(
                                                          //     context, HomePage());
                                                          Navigator.push(
                                                            context,
                                                            PageTransition(
                                                              type:
                                                                  PageTransitionType
                                                                      .fade,
                                                              child: HomePage(),
                                                            ),
                                                          );

                                                          Navigator.of(context,
                                                                  rootNavigator:
                                                                      true)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                          "Tiếp tục mua sắm",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            FlatButton(
                                              child: Text("Đơn hàng đã mua"),
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 10.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        "Thanh toán",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 15.0,
                                horizontal: 10.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Text("Chỉnh sửa thông tin",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFFDBCC8F),
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        case CheckOutStatus.failure:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
