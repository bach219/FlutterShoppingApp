import 'package:flutter/material.dart';
import 'package:flutter_icons/ionicons.dart';
import 'package:fluttercommerce/cart/models/models.dart';
import 'package:fluttercommerce/utils/navigator.dart';
import 'package:fluttercommerce/screens/screens.dart';
import 'package:fluttercommerce/cart/bloc/cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:hive/hive.dart';
import 'package:fluttercommerce/product_detail/view/product_detail_view/product_detail_page.dart';

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
              backgroundColor: Color(0xFFDBCC8F),
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
                  color: Color(0xFFDBCC8F),
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
                                color: Colors.black,
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
          // print(state.cart.items);
          return Container(
              padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              // height: 220,
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
                                  FadeInImage.assetNetwork(
                                    placeholder: "assets/Spinner.gif",
                                    image:
                                        "http://192.168.100.18/AppStore/public/layout/images/avatar/${state.cart.items[pos].icon}",
                                    fit: BoxFit.fitHeight,
                                    height: 150,
                                  ),
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
                                            context.read<CartBloc>().add(
                                                CartItemSubUpdated(Item(
                                                    id: state
                                                        .cart.items[pos].id,
                                                    company: state.cart
                                                        .items[pos].company,
                                                    name: state
                                                        .cart.items[pos].name,
                                                    icon: state
                                                        .cart.items[pos].icon,
                                                    rating: 4.5,
                                                    remainingQuantity: state
                                                        .cart
                                                        .items[pos]
                                                        .remainingQuantity,
                                                    price: state
                                                        .cart.items[pos].price,
                                                    sale: state
                                                        .cart.items[pos].sale,
                                                    qty: state
                                                        .cart.items[pos].qty)));
                                          },
                                        ),
                                        Text(
                                          // 'fsdfdvvcshoppingCartCount',
                                          state.cart.items[pos].qty.toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add_circle_outline),
                                          onPressed: () {
                                            // setState(() {
                                            //   shoppingCartCount++;
                                            // });
                                            context.read<CartBloc>().add(
                                                CartItemAddUpdated(Item(
                                                    id: state
                                                        .cart.items[pos].id,
                                                    company: state.cart
                                                        .items[pos].company,
                                                    name: state
                                                        .cart.items[pos].name,
                                                    icon: state
                                                        .cart.items[pos].icon,
                                                    rating: 4.5,
                                                    remainingQuantity: state
                                                        .cart
                                                        .items[pos]
                                                        .remainingQuantity,
                                                    price: state
                                                        .cart.items[pos].price,
                                                    sale: state
                                                        .cart.items[pos].sale,
                                                    qty: state
                                                        .cart.items[pos].qty)));
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
                                        onPressed: () {
                                          context.read<CartBloc>().add(
                                              CartItemDeleted(Item(
                                                  id: state.cart.items[pos].id,
                                                  company: state
                                                      .cart.items[pos].company,
                                                  name: state
                                                      .cart.items[pos].name,
                                                  icon: state
                                                      .cart.items[pos].icon,
                                                  rating: 4.5,
                                                  remainingQuantity: state
                                                      .cart
                                                      .items[pos]
                                                      .remainingQuantity,
                                                  price: state
                                                      .cart.items[pos].price,
                                                  sale: state
                                                      .cart.items[pos].sale,
                                                  qty: state
                                                      .cart.items[pos].qty)));
                                        },
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
                                            NumberFormat.currency(locale: 'vi')
                                                .format((state
                                                        .cart.items[pos].price *
                                                    (1 -
                                                        state.cart.items[pos]
                                                                .sale /
                                                            100))),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                          ),
                                        ),
                                        state.cart.items[pos].sale > 0
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text(
                                                  NumberFormat.currency(
                                                          locale: 'vi')
                                                      .format((state.cart
                                                          .items[pos].price)),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                                ),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                              ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: GestureDetector(
                                            onTap: () async {
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child: ProductDetailPage(),
                                                ),
                                              );
                                              await Hive.openBox('Box');
                                              var box = Hive.box('Box');
                                              box.put('idDetail',
                                                  state.cart.items[pos].id);
                                              box.put(
                                                  'companyDetail',
                                                  state
                                                      .cart.items[pos].company);
                                            },
                                            child: Text(
                                              "Chi tiết sản phẩm",
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.blue),
                                              textAlign: TextAlign.end,
                                            ),
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
                        Text(NumberFormat.currency(locale: 'vi')
                            .format((state.cart.totalPrice))),
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
                          NumberFormat.currency(locale: 'vi')
                              .format((state.cart.totalPrice * 0.1)),
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
                        Text(NumberFormat.currency(locale: 'vi')
                            .format((state.cart.totalPrice * 1.1))),
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
