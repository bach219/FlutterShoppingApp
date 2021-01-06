import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttercommerce/painters/circlepainters.dart';
import 'package:fluttercommerce/screens/screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/home/bloc/list_functionality_bloc/list_functionality.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttercommerce/login/view/login_page.dart';
import 'package:fluttercommerce/product_list/view/product_list_view.dart';

class ListFunctionality extends StatefulWidget {
  @override
  _ListFunctionalityState createState() => _ListFunctionalityState();
}

class _ListFunctionalityState extends State<ListFunctionality> {
  double widget1Opacity = 0.0;
  List<String> categories = [
    'menu.png',
    'telephone.png',
    'camera.png',
    'laptop.png',
    'tablet32.png',
    'speaker.png',
    'watch.png',
  ];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      widget1Opacity = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListFunctionalityBloc, ListFunctionalityState>(
        builder: (context, state) {
      switch (state.status) {
        case ListFunctionalityStatus.failure:
          return LoginPage();
        case ListFunctionalityStatus.initial:
          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 11,
              child: Center(child: Image.asset("assets/Spinner.gif")));
        case ListFunctionalityStatus.success:
          List<String> listFunctionality = [];
          listFunctionality.add("Trọn bộ");
          state.listFunctionality.map((func) {
            listFunctionality.add(func.name.toString());
            // print(func.name);
          }).toList();
          return CustomPaint(
            painter: LinePainter(),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 12),
                  height: 90,
                  child: AnimatedOpacity(
                    opacity: widget1Opacity,
                    duration: Duration(seconds: 3),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: listFunctionality.length,
                      itemBuilder: (context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: ProductListPage(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  width: 55,
                                  height: 55,
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.blueGrey,
                                      width: 1,
                                    ),
                                  ),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    child: FadeInImage(
                                      placeholder:
                                          AssetImage("assets/Spinner.gif"),
                                      image: AssetImage(
                                          "assets/images/${categories[index]}"),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "    " + listFunctionality[index] + "    ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Regular',
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        default:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
