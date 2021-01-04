import 'package:flutter/material.dart';
import 'package:fluttercommerce/utils/constant.dart';
import 'package:fluttercommerce/search/bloc/search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/models/product.dart';
import 'package:fluttercommerce/Repository/repository.dart';
import 'package:fluttercommerce/screens/product.dart';
import 'package:intl/intl.dart';
import 'package:fluttercommerce/widgets/star_rating.dart';
import 'package:fluttercommerce/home/home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttercommerce/product_detail/view/product_detail_view/product_detail_page.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _textController = TextEditingController();
  String get _search => _textController.text;
  List<Product> listSearch = [];
  bool _startSearch = false;
  String _errorText = "";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
        // ignore: missing_return
        builder: (context, state) {
      switch (state.status) {
        case SearchStatus.initial:
          List<String> listImage = [];
          state.listImage.map((e) => listImage.add(e));
          return Scaffold(
            body: Container(
              padding: EdgeInsets.only(
                top: 45.0,
                left: 10.0,
                right: 10.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _textController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Sản phẩm cần tìm kiếm',
                        helperText: _errorText,
                        hintStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        contentPadding: EdgeInsets.all(16),
                        fillColor: Color(0xFFDBCC8F),
                        prefixIcon: Icon(
                          Icons.mic,
                          color: Colors.black,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 28,
                          ),
                          onPressed: () async {
                            List<Product> getSearch = await ProductRepository()
                                .getlistSearch(_search);
                            print(getSearch);
                            setState(() {
                              listSearch = getSearch;
                            });
                            _startSearch = true;
                            _errorText = (listSearch != null
                                    ? listSearch.length.toString()
                                    : "0") +
                                " sản phẩm";
                          },
                        ),
                      ),
                    ),
                    !_startSearch
                        ? ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            controller:
                                ScrollController(keepScrollOffset: false),
                            itemCount: listImage.length,
                            itemBuilder: (context, pos) {
                              return Container(
                                  margin: EdgeInsets.only(bottom: 20.0),
                                  height: 148,
                                  child: new ClipRRect(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    child: GestureDetector(
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  listImage[pos],
                                                ),
                                              ),
                                            ),
                                            height: 200.0,
                                          ),
                                          Container(
                                            height: 350.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                gradient: LinearGradient(
                                                    begin: FractionalOffset
                                                        .topCenter,
                                                    end: FractionalOffset
                                                        .bottomCenter,
                                                    colors: [
                                                      Colors.black26,
                                                      Colors.black26,
                                                    ],
                                                    stops: [
                                                      0.0,
                                                      1.0
                                                    ])),
                                          ),
                                          Center(
                                            child: Text(
                                              "Bach\'s Shop",
                                              style: TextStyle(
                                                  fontSize: 26,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.fade,
                                            child: HomePage(),
                                          ),
                                        );
                                      },
                                    ),
                                  ));
                            },
                          )
                        : listSearch != null
                            ? ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                controller:
                                    ScrollController(keepScrollOffset: false),
                                itemCount: listSearch.length,
                                itemBuilder: (context, pos) {
                                  return GestureDetector(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(13),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0xFFDBCC8F),
                                              blurRadius: 10,
                                              spreadRadius: 3,
                                              offset: Offset(3, 4))
                                        ],
                                      ),
                                      child: ListTile(
                                        leading: FadeInImage.assetNetwork(
                                          placeholder: "assets/Spinner.gif",
                                          image:
                                              "http://192.168.100.18/AppStore/public/layout/images/avatar/${listSearch[pos].icon}",
                                          fit: BoxFit.contain,
                                          width: 100,
                                          height: 100,
                                        ),
                                        title: Text(
                                          listSearch[pos].company,
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        subtitle: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              listSearch[pos].name,
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              softWrap: false,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                                NumberFormat.currency(
                                                        locale: 'vi')
                                                    .format(
                                                        (listSearch[pos].price *
                                                            (1 -
                                                                listSearch[pos]
                                                                        .sale /
                                                                    100))),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.red)),
                                            Text(
                                                listSearch[pos].sale > 0
                                                    ? NumberFormat.currency(
                                                            locale: 'vi')
                                                        .format((listSearch[pos]
                                                            .price))
                                                    : "",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10,
                                                    decoration: TextDecoration
                                                        .lineThrough)),
                                            StarRating(
                                                rating: listSearch[pos].rating,
                                                size: 10),
                                            SizedBox(height: 10),
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailPage(
                                            product: Product(
                                              id: listSearch[pos].id,
                                              company: listSearch[pos].company,
                                              name: listSearch[pos].name,
                                              icon: listSearch[pos].icon,
                                              rating: 5.0,
                                              price: listSearch[pos].price,
                                              remainingQuantity: listSearch[pos]
                                                  .remainingQuantity,
                                              description:
                                                  listSearch[pos].description,
                                              sale: listSearch[pos].sale,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              )
                            : Column(
                                // mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text('🙈',
                                      style: TextStyle(fontSize: 64)),
                                  Text(
                                    'Không tìm thấy sản phẩm!',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ],
                              )
                  ],
                ),
              ),
            ),
          );
        case SearchStatus.failure:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
