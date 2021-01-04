import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttercommerce/utils/navigator.dart';
import 'package:fluttercommerce/widgets/star_rating.dart';
import 'package:fluttercommerce/screens/product.dart';
import 'package:fluttercommerce/product_detail/view/product_detail_view/product_detail_page.dart';

import '../models/product.dart';

class Occasions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Nav.route(
            context,
            ProductDetailPage(
              product: Product(
                  company: 'Apple',
                  name: 'iPhone 7 plus (128GB)',
                  icon: 'assets/iphone_7.png',
                  rating: 4.5,
                  remainingQuantity: 5,
                  price: 2000),
            ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 220,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Siêu phẩm cuối năm",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFDBCC8F)),
                        textAlign: TextAlign.start,
                      ),
                      Icon(
                        SimpleLineIcons.getIconData("screen-smartphone"),
                        color: Colors.black54,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Divider(
                      color: Colors.black12,
                      height: 1,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Colors.black12)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/iphone_x.png',
                              height: 120,
                              width: MediaQuery.of(context).size.width / 3),
                        ),
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      Container(
                        height: 142,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Colors.black12)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "06 : 43 : 32",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  "Iphone Xs Max",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "5.365 TL",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    '#6.789',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        decoration: TextDecoration.lineThrough),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: StarRating(rating: 4, size: 10),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text("Miễn phí vận chuyển"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  "Số lượng có hạn",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            elevation: 5,
          ),
        ),
      ),
    );
  }
}
