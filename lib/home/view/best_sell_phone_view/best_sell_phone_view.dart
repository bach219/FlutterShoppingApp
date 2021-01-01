import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttercommerce/models/product.dart';
import 'package:fluttercommerce/screens/product.dart';
import 'package:fluttercommerce/utils/navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/home/bloc/best_sell_phone_bloc/best_sell_phone.dart';
import 'package:fluttercommerce/widgets/star_rating.dart';
import 'package:intl/intl.dart';

class BestSellPhone extends StatefulWidget {
  @override
  _BestSellPhoneState createState() => _BestSellPhoneState();
}

class _BestSellPhoneState extends State<BestSellPhone> {
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
    return BlocBuilder<BestSellPhoneBloc, BestSellPhoneState>(
        builder: (context, state) {
      switch (state.status) {
        case BestSellPhoneStatus.failure:
          return const Center(child: CircularProgressIndicator());
        case BestSellPhoneStatus.initial:
          Product bestSell = state.bestSell;
          // print(state.bestSell.toString() + "Viewwwwwwwwwwwwwwwwwwwwwwww");
          return InkWell(
            onTap: () {
              Nav.route(
                  context,
                  ProductPage(
                    product: Product(
                      company: bestSell.company,
                      name: bestSell.name,
                      icon: bestSell.icon,
                      rating: 5.0,
                      remainingQuantity: bestSell.remainingQuantity,
                      price: bestSell.price,
                      sale: bestSell.sale,
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
                                  "Bán chạy nhất năm",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFDBCC8F)),
                                  textAlign: TextAlign.start,
                                ),
                                Icon(
                                  SimpleLineIcons.getIconData("energy"),
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
                                          "http://192.168.100.18/AppStore/public/layout/images/avatar/${bestSell.icon}",
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
                                              bestSell.name,
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
                                                .format((bestSell.price *
                                                    (1 - bestSell.sale / 100))),
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
                                          NumberFormat.currency(locale: 'vi')
                                              .format((bestSell.price)),
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
                                          "Số lượng có hạn: ${bestSell.remainingQuantity}",
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
