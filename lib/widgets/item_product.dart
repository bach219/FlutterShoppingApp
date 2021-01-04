import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/ionicons.dart';
import 'package:fluttercommerce/models/product.dart';
import 'package:fluttercommerce/product_detail/view/product_detail_view/product_detail_page.dart';
// import 'package:fluttercommerce/screens/product.dart';
import 'package:fluttercommerce/widgets/star_rating.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

class TrendingItem extends StatelessWidget {
  final Product product;
  final List<Color> gradientColors;

  TrendingItem({this.product, this.gradientColors});

  @override
  Widget build(BuildContext context) {
    double trendCardWidth = 180;

    return GestureDetector(
      child: Stack(
        children: <Widget>[
          Container(
            width: trendCardWidth,
            child: Card(
              elevation: 2,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Spacer(),
                        Icon(
                          Ionicons.getIconData("ios-link"),
                          color: Colors.black54,
                        )
                      ],
                    ),
                    _productImage(),
                    _productDetails()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      onTap: () async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              product: product,
            ),
          ),
        );
        await Hive.openBox('Box');
        var box = Hive.box('Box');
        box.put('idDetail', product.id);
        // box.put('idDetail', product.id);
        // var id = box.get('idDetail');
        print("${product.id} itemproduct");
      },
    );
  }

  _productImage() {
    // print("image");
    // print(product.icon);
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            width: 100,
            height: 75,
            child: FadeInImage.assetNetwork(
              placeholder: "assets/Spinner.gif",
              image:
                  "http://192.168.100.18/AppStore/public/layout/images/avatar/${product.icon}",
              fit: BoxFit.contain,
            ),
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //       image: AssetImage(product.icon), fit: BoxFit.contain),
            // ),
          ),
        )
      ],
    );
  }

  _productDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          product.company,
          style: TextStyle(fontSize: 12, color: Color(0XFFb1bdef)),
        ),
        Text(
          product.name,
          overflow: TextOverflow.fade,
          maxLines: 1,
          softWrap: false,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        ),
        StarRating(rating: product.rating, size: 10),
        Row(
          children: <Widget>[
            Text(
                NumberFormat.currency(locale: 'vi')
                    .format((product.price * (1 - product.sale / 100))),
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.red)),
          ],
        ),
        product.sale > 0.0
            ? Text(
                NumberFormat.currency(locale: 'vi').format((product.price)),
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    decoration: TextDecoration.lineThrough),
              )
            : Text(''),
      ],
    );
  }
}
