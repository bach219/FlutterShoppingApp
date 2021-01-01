import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttercommerce/models/product.dart';
import 'package:fluttercommerce/widgets/item_product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/home/bloc/list_sell_product_bloc/list_sell_product_bloc.dart';

class ListSellProduct extends StatefulWidget {
  @override
  _ListSellProductState createState() => _ListSellProductState();
}

class _ListSellProductState extends State<ListSellProduct> {
  double widget1Opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      widget1Opacity = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListProductBloc, ListProductState>(
        builder: (context, state) {
      switch (state.status) {
        case ListProductStatus.initial:
          List<Product> listSell = [];
          state.listSell.map((func) {
            listSell.add(func);
          }).toList();
          return Column(
            children: <Widget>[
              Container(
                height: 200,
                child: AnimatedOpacity(
                  opacity: widget1Opacity,
                  duration: Duration(seconds: 3),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: listSell.length,
                    itemBuilder: (context, int index) {
                      return TrendingItem(
                        product: Product(
                            company: listSell[index].company,
                            name: listSell[index].name,
                            icon: listSell[index].icon,
                            rating: 4.5,
                            remainingQuantity:
                                listSell[index].remainingQuantity,
                            price: listSell[index].price),
                        gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
                      );
                    },
                  ),
                ),
              )
            ],
          );
        case ListProductStatus.failure:
          return const Center(child: CircularProgressIndicator());
        default:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}