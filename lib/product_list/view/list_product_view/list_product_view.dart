import 'package:flutter_icons/ionicons.dart';
import 'package:flutter_icons/material_community_icons.dart';
import 'package:fluttercommerce/models/product.dart';
import 'package:fluttercommerce/product_list/view/product_list_view.dart';
import 'package:fluttercommerce/widgets/item_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:fluttercommerce/product_list/bloc/list_product_bloc/list_product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/cart/bloc/cart.dart';
import 'package:fluttercommerce/cart/view/cart_view.dart';
import 'package:fluttercommerce/search/view/search_page.dart';

class ProductList extends StatefulWidget {
  // final Product product;

  // ProductList({this.product});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  double widget1Opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      widget1Opacity = 1;
    });
  }

  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );

  PanelController slidingUpController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListProductBloc, ListProductState>(
        // ignore: missing_return
        builder: (context, state) {
      if (state is ListProductLoading)
        return Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 11,
            child: Center(child: Image.asset("assets/Spinner.gif")));
      if (state is ListProductLoaded) {
        var size = MediaQuery.of(context).size;
        /*24 is for notification bar on Android*/
        final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
        final double itemWidth = size.width / 2;
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(
              "Danh sách sản phẩm",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            leading: IconButton(
              icon: Icon(Ionicons.getIconData("ios-arrow-back"),
                  color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: SizedBox(
                  height: 38.0,
                  width: 20.0,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: SearchPage(),
                        ),
                      );
                    },
                    icon: Icon(
                      MaterialCommunityIcons.getIconData("magnify"),
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: Stack(
                    children: [
                      IconButton(
                        icon: Icon(
                          MaterialCommunityIcons.getIconData("cart-outline"),
                        ),
                        color: Colors.black,
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: ShoppingCart(true),
                            ),
                          );
                        },
                      ),
                      Cart()
                    ],
                  ),
                ),
              ),
            ],
            backgroundColor: Color(0xFFDBCC8F),
          ),
          body: AnimatedOpacity(
            opacity: widget1Opacity,
            duration: Duration(seconds: 3),
            child: SlidingUpPanel(
              controller: slidingUpController,
              minHeight: 42,
              color: Colors.blueGrey,
              panel: FilterView(),
              collapsed: Container(
                decoration: BoxDecoration(
                    color: Color(0xFFDBCC8F), borderRadius: radius),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_upward,
                        color: Colors.black,
                        size: 16,
                      ),
                    ),
                    Text(
                      "Lọc sản phẩm",
                      style: TextStyle(color: Colors.black),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_upward,
                        color: Colors.black,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
              borderRadius: radius,
              body: Container(
                padding: EdgeInsets.only(top: 18),
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: (itemWidth / itemHeight) * 1.1,
                  controller: ScrollController(keepScrollOffset: false),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children:
                      List.generate(state.listProduct.length + 1, (index) {
                    if (index == state.listProduct.length ||
                        index == state.listProduct.length + 1)
                      return Container();
                    return Center(
                        child: TrendingItem(
                      product: Product(
                          id: state.listProduct[index].id,
                          company: state.listProduct[index].company,
                          name: state.listProduct[index].name,
                          icon: state.listProduct[index].icon,
                          rating: 4.5,
                          remainingQuantity:
                              state.listProduct[index].remainingQuantity,
                          price: state.listProduct[index].price,
                          sale: state.listProduct[index].sale),
                      gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
                    ));
                  }),
                ),
              ),
            ),
          ),
        );
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      print("state:              $state");
      if (state is CartLoading) {
        return const CircularProgressIndicator();
      }
      if (state is CartLoaded) {
        return Positioned(
            left: 1,
            bottom: 10,
            child: state.cart.totalLength > 0
                ? Text(state.cart.totalLength.toString(),
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        height: 5,
                        fontSize: 12))
                : Text(""));
      }
      return const Text('Something went wrong!');
    });
  }
}
