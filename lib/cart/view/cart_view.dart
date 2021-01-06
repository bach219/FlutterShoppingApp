import 'package:flutter/material.dart';
import 'package:flutter_icons/ionicons.dart';
import 'package:fluttercommerce/utils/navigator.dart';
import 'package:fluttercommerce/screens/screens.dart';
import 'package:fluttercommerce/cart/bloc/cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ShoppingCart extends StatefulWidget {
  bool showAppBar = true;

  ShoppingCart(this.showAppBar);

  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  int shoppingCartCount = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppBar
          ? AppBar(
              title: Text(
                "Giỏ hàng",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              leading: IconButton(
                icon: Icon(Ionicons.getIconData("ios-arrow-back"),
                    color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              backgroundColor: Colors.white,
            )
          : null,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // buildShoppingCartItem(context),
              _CartList(),
              _CartTotal(),
              Padding(
                padding: EdgeInsets.only(
                    top: 8.0, left: 8.0, right: 8.0, bottom: 16.0),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  color: Colors.blueGrey,
                  onPressed: () => {Nav.route(context, Checkout())},
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
                            "Đặt hàng",
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
            ],
          ),
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const CircularProgressIndicator();
        }
        if (state is CartLoaded) {
          return Container(
              padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              height: 220,
              child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    controller: ScrollController(keepScrollOffset: false),
                    itemCount: state.cart.items.length,
                    itemBuilder: (context, pos) {
                      return Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              width: (MediaQuery.of(context).size.width) / 3,
                              child: Column(
                                children: <Widget>[
                                  Image.asset('assets/raf.jpg'),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        IconButton(
                                          icon:
                                              Icon(Icons.remove_circle_outline),
                                          onPressed: () {
                                            // setState(() {
                                            //   shoppingCartCount--;
                                            // });
                                          },
                                        ),
                                        Text(
                                          'fsdfdvvcshoppingCartCount',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add_circle_outline),
                                          onPressed: () {
                                            // setState(() {
                                            //   shoppingCartCount++;
                                            // });
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: (MediaQuery.of(context).size.width - 37) /
                                  1.5,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(left: 12.0),
                                        width: 150,
                                        child: Text(
                                          state.cart.items[pos].name,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          size: 26,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            "\$ 2.500",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            "Chi tiết sản phẩm",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ])));
        }
        return const Text('Something went wrong!');
      },
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const CircularProgressIndicator();
        }
        if (state is CartLoaded) {
          return Container(
            padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            height: 120,
            child: Card(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Tiền hàng"),
                        Text("\$278.78"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Thuế VAT"),
                        Text(
                          "\$20.00",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Tổng hóa đơn",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("\$308.78"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const Text('Something went wrong!');
      },
    );
  }
}

// Container buildShoppingCartItem(BuildContext context) {
//   return Container(
//       padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
//       height: 220,
//       child: SingleChildScrollView(
//           child: Column(children: <Widget>[
//         Card(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               Container(
//                 width: (MediaQuery.of(context).size.width) / 3,
//                 child: Column(
//                   children: <Widget>[
//                     Image.asset('assets/raf.jpg'),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: <Widget>[
//                           IconButton(
//                             icon: Icon(Icons.remove_circle_outline),
//                             onPressed: () {
//                               setState(() {
//                                 shoppingCartCount--;
//                               });
//                             },
//                           ),
//                           Text(
//                             '$shoppingCartCount',
//                             style: TextStyle(fontSize: 18),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.add_circle_outline),
//                             onPressed: () {
//                               setState(() {
//                                 shoppingCartCount++;
//                               });
//                             },
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 width: (MediaQuery.of(context).size.width - 37) / 1.5,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Container(
//                           padding: EdgeInsets.only(left: 12.0),
//                           width: 150,
//                           child: Text(
//                             "Philips 42FYHFH45 81 Cm FullHD",
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 2,
//                           ),
//                         ),
//                         IconButton(
//                           icon: Icon(
//                             Icons.close,
//                             size: 26,
//                           ),
//                           onPressed: () {},
//                         ),
//                       ],
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: <Widget>[
//                           Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: Text(
//                               "\$ 2.500",
//                               style: TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: Text(
//                               "Show Details",
//                               style: TextStyle(color: Colors.blue),
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ])));
// }
// }
