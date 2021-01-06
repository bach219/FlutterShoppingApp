import 'package:flutter_icons/ionicons.dart';
import 'package:flutter_icons/material_community_icons.dart';
import 'package:fluttercommerce/models/product.dart';
import 'package:fluttercommerce/widgets/filter.dart';
import 'package:fluttercommerce/widgets/item_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:fluttercommerce/product_list/bloc/list_product_bloc/list_product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      switch (state.status) {
        case ListProductStatus.failure:
          return const Center(child: CircularProgressIndicator());
        case ListProductStatus.initial:
          return Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 11,
              child: Center(child: Image.asset("assets/Spinner.gif")));
        case ListProductStatus.success:
          List<Product> listNew = [];
          state.listNew.map((func) {
            listNew.add(func);
          }).toList();
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
                    height: 18.0,
                    width: 18.0,
                    child: IconButton(
                      onPressed: () {},
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
                    height: 18.0,
                    width: 18.0,
                    child: IconButton(
                      icon: Icon(
                        MaterialCommunityIcons.getIconData("cart-outline"),
                      ),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: ProductList(),
                          ),
                        );
                      },
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
                panel: Filtre(),
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
                    children: List.generate(listNew.length + 1, (index) {
                      if (index == listNew.length - 1 ||
                          index == listNew.length) return Container();
                      return Center(
                          child: TrendingItem(
                        product: Product(
                            id: listNew[index].id,
                            company: listNew[index].company,
                            name: listNew[index].name,
                            icon: listNew[index].icon,
                            rating: 4.5,
                            remainingQuantity: listNew[index].remainingQuantity,
                            price: listNew[index].price,
                            sale: listNew[index].sale),
                        gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
                      ));
                    }),
                  ),
                ),
              ),
            ),
          );
      }
    });
  }
}
