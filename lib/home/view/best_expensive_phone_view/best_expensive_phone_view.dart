import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttercommerce/models/product.dart';
import 'package:fluttercommerce/screens/product.dart';
import 'package:fluttercommerce/utils/navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/home/bloc/best_expensive_phone_bloc/best_expensive_phone.dart';
import 'package:fluttercommerce/product_detail/view/product_detail_view/product_detail_page.dart';
import 'package:fluttercommerce/widgets/star_rating.dart';
import 'package:intl/intl.dart';

class BestExpensivePhone extends StatefulWidget {
  @override
  _BestExpensivePhoneState createState() => _BestExpensivePhoneState();
}

class _BestExpensivePhoneState extends State<BestExpensivePhone> {
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
    return BlocBuilder<BestExpensivePhoneBloc, BestExpensivePhoneState>(
        builder: (context, state) {
      switch (state.status) {
        case BestExpensivePhoneStatus.failure:
          return const Center(child: CircularProgressIndicator());
        case BestExpensivePhoneStatus.initial:
          Product bestExpensive = state.bestExpensive;
          // print(state.bestExpensive.toString() + "Viewwwwwwwwwwwwwwwwwwwwwwww");
          return InkWell(
            onTap: () {
              Nav.route(
                  context,
                  ProductDetailPage(
                    product: Product(
                      id: bestExpensive.id,
                      company: bestExpensive.company,
                      name: bestExpensive.name,
                      icon: bestExpensive.icon,
                      rating: 5.0,
                      remainingQuantity: bestExpensive.remainingQuantity,
                      price: bestExpensive.price,
                      sale: bestExpensive.sale,
                    ),
                  ));
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: AnimatedOpacity(
                  opacity: widget1Opacity,
                  duration: Duration(seconds: 1),
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
                                  "Siêu phẩm của năm",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFDBCC8F)),
                                  textAlign: TextAlign.start,
                                ),
                                Icon(
                                  SimpleLineIcons.getIconData("diamond"),
                                  color: Colors.black54,
                                )
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: Divider(
                                color: Colors.black12,
                                height: 1,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black12)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FadeInImage.assetNetwork(
                                      height: 133,
                                      placeholder: "assets/Spinner.gif",
                                      image:
                                          "http://192.168.100.18/AppStore/public/layout/images/avatar/${bestExpensive.icon}",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 24,
                                ),
                                Expanded(
                                  // height: 150,
                                  // decoration: BoxDecoration(
                                  //     border: Border.all(
                                  //         width: 1, color: Colors.black12)),
                                  // child: Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      // Text(
                                      //   "06 : 43 : 32",
                                      //   style: TextStyle(
                                      //     fontSize: 14,
                                      //   ),
                                      // ),
                                      Column(
                                          // padding: const EdgeInsets.symmetric(
                                          //     vertical: 4.0),
                                          children: [
                                            Text(
                                              bestExpensive.name,
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              softWrap: false,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ]),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            NumberFormat.currency(locale: 'vi')
                                                .format((bestExpensive.price *
                                                    (1 -
                                                        bestExpensive.sale /
                                                            100))),
                                            overflow: TextOverflow.fade,
                                            maxLines: 1,
                                            softWrap: false,
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                          ),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          StarRating(rating: 4.5, size: 10),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          bestExpensive.sale > 0.0
                                              ? NumberFormat.currency(
                                                      locale: 'vi')
                                                  .format((bestExpensive.price))
                                              : "",
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: Text("Miễn phí vận chuyển"),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          "Số lượng có hạn: ${bestExpensive.remainingQuantity}",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // ),
                              ],
                            )
                          ],
                        ),
                      ),
                      elevation: 5,
                    ),
                  ),
                )),
          );
        default:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
