import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttercommerce/models/models.dart';
import 'package:fluttercommerce/models/product.dart';
import 'package:fluttercommerce/product_detail/bloc/product_detail_bloc/product_detail.dart';
import './product_detail_page.dart';
import 'package:fluttercommerce/utils/colors.dart';
import 'package:fluttercommerce/widgets/dotted_slider.dart';
import 'package:fluttercommerce/widgets/item_product.dart';
import 'package:fluttercommerce/widgets/star_rating.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:fluttercommerce/search/view/search_page.dart';
import 'package:intl/intl.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttercommerce/product_list/view/product_list_view.dart';
import 'package:fluttercommerce/cart/bloc/cart.dart';
import 'package:fluttercommerce/cart/view/cart_view.dart';
import 'package:fluttercommerce/cart/models/models.dart';
import 'package:hive/hive.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  ProductPage({this.product});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool isClicked = false;

  Product product;
  List<Comment> listComment;
  List<Product> listMore;
  List<Images> listImage;
  double widget1Opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Hive.registerAdapter<Item>(ItemAdapter());
    Future.delayed(Duration(milliseconds: 100), () {
      widget1Opacity = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
        // ignore: missing_return
        builder: (context, state) {
      switch (state.status) {
        case ProductDetailStatus.failure:
          return const Center(child: CircularProgressIndicator());

        case ProductDetailStatus.initial:
          return Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 11,
              child: Center(child: Image.asset("assets/Spinner.gif")));
        case ProductDetailStatus.success:
          product = state.product;
          listImage = state.listImages.map((e) => (e)).toList();
          listComment = state.listComment.map((e) => (e)).toList();
          listMore = state.listMore.map((e) => (e)).toList();

          return Scaffold(
            // appBar: AppBar(
            //   // title: Text(
            //   //   product.name,
            //   //   style: TextStyle(color: Colors.black, fontSize: 16),
            //   // ),
            //   leading: IconButton(
            //     icon: Icon(Ionicons.getIconData("ios-arrow-back"),
            //         color: Colors.black),
            //     onPressed: () => Navigator.pop(context),
            //   ),
            //   // backgroundColor: Colors.white,
            // ),
            bottomNavigationBar: Container(
              color: Theme.of(context).backgroundColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 11,
              child: AnimatedOpacity(
                opacity: widget1Opacity,
                duration: Duration(seconds: 1),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.black12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          product.sale > 0
                              ? Column(
                                  children: [
                                    Text(
                                      NumberFormat.currency(locale: 'vi')
                                          .format((product.price *
                                              (1 - product.sale / 100))),
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      softWrap: false,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      NumberFormat.currency(locale: 'vi')
                                          .format((product.price)),
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      softWrap: false,
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 14,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                  ],
                                )
                              : Center(
                                  child: Text(
                                    NumberFormat.currency(locale: 'vi').format(
                                        (product.price *
                                            (1 - product.sale / 100))),
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      AddItem(product: product)
                    ],
                  ),
                ),
              ),
            ),
            body: AnimatedOpacity(
              opacity: widget1Opacity,
              duration: Duration(seconds: 1),
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      actions: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: SearchPage(),
                              ),
                            );
                          },
                          child: Icon(
                            MaterialCommunityIcons.getIconData("magnify"),
                            color: Colors.black,
                          ),
                        ),
                        Stack(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                MaterialCommunityIcons.getIconData(
                                    "cart-outline"),
                              ),
                              color: Colors.black,
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ShoppingCart(true),
                                  ),
                                );
                              },
                            ),
                            isClicked
                                ? Positioned(
                                    left: 5,
                                    bottom: 10,
                                    child: Text("122",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            backgroundColor: Colors.red,
                                            fontSize: 12))
                                    // Icon(
                                    //   Icons.looks_one,
                                    //   size: 14,
                                    //   color: Colors.red,
                                    // ),
                                    )
                                : Text(""),
                          ],
                        ),
                      ],
                      iconTheme: IconThemeData(
                        color: Colors.black, //change your color here
                      ),
                      backgroundColor: Colors.white,
                      expandedHeight: MediaQuery.of(context).size.height / 2.4,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text(
                          product.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                        background: Padding(
                          padding: EdgeInsets.only(top: 48.0),
                          child: dottedSlider(listImage),
                        ),
                      ),
                    ),
                  ];
                },
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _buildInfo(context), //Product Info
                        _buildExtra(context),
                        _buildDescription(context),
                        _buildComments(context, listComment),
                        _buildProducts(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
      }
    });
  }

  // showAlertDialog(BuildContext context) {
  //   // set up the button
  //   Widget okButton = FlatButton(
  //     child: Text("OK"),
  //     onPressed: () {
  //       Navigator.of(context).pop();
  //     },
  //   );

  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     title: Text("Shopping Cart"),
  //     content: Text("Your product has been added to cart."),
  //     actions: [
  //       okButton,
  //     ],
  //   );

  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  dottedSlider(List<Images> listImage) {
    // print("dottedSlider: ${listImage.toString()}");
    return DottedSlider(
        maxHeight: 200,
        children: listImage
            .map((e) => Container(
                  height: 200,
                  width: double.infinity,
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/Spinner.gif",
                    image:
                        "http://192.168.100.18/AppStore/public/layout/images/avatar/${e.image}",
                    fit: BoxFit.contain,
                  ),
                ))
            .toList());
  }

  _buildInfo(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: 130,
                    child: Text("Số lượng",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14))),
                SizedBox(
                  width: 48,
                ),
                Text(product.remainingQuantity.toString() + " sản phẩm"),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: 130,
                    child: Text("Hãng sản xuất",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14))),
                SizedBox(
                  width: 48,
                ),
                Text(product.company),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: StarRating(rating: product.rating, size: 20),
            ),
          ],
        ),
      ),
    );
  }

  _buildExtra(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(width: 1.0, color: Colors.black12),
        bottom: BorderSide(width: 1.0, color: Colors.black12),
      )),
      padding: EdgeInsets.all(4.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              product.ram != "null"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 130,
                          child: Text(
                            "RAM",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          width: 48,
                        ),
                        OutlineButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0)),
                          child: Text(product.ram + " GB"),
                          onPressed: () {}, //callback when button is clicked
                          borderSide: BorderSide(
                            color: Colors.red, //Color of the border
                            style: BorderStyle.solid, //Style of the border
                            width: 0.8, //width of the border
                          ),
                        ),
                      ],
                    )
                  : SizedBox(),
              SizedBox(
                height: 8,
              ),
              product.ram != 'null'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 130,
                          child: Text("Bộ nhớ trong",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                        ),
                        SizedBox(
                          width: 48,
                        ),
                        Row(
                          children: <Widget>[
                            OutlineButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(8.0)),
                              child: Text(product.hardDrive + " GB"),
                              onPressed:
                                  () {}, //callback when button is clicked
                              borderSide: BorderSide(
                                color:
                                    Colors.orangeAccent, //Color of the border
                                style: BorderStyle.solid, //Style of the border
                                width: 1.5, //width of the border
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : SizedBox(),
              SizedBox(
                height: 16,
              ),
              product.promotion != 'null'
                  ? Column(
                      children: [
                        Container(
                          height: 25,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text("Khuyến mãi",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.red)),
                          ),
                        ),
                        Html(
                          data: """${product.promotion}""",
                        ),
                      ],
                    )
                  : SizedBox(),
              SizedBox(
                height: 8,
              ),
              product.accessories != 'null'
                  ? Column(
                      children: [
                        Container(
                          height: 25,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text("Phụ kiện",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                          ),
                        ),
                        Html(
                          data: """${product.accessories}""",
                        )
                      ],
                    )
                  : SizedBox(),
              SizedBox(
                height: 18,
              ),
              Container(
                height: 25,
                child: Text("Bảo hành",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ),
              Html(
                data: """${product.warranty}""",
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildDescription(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.8,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Mô tả sản phẩm",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black45,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              product.name,
            ),
            // SingleChildScrollView(child: Html(data: """${product.name}""",)),
            SizedBox(
              height: 8,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  _settingModalBottomSheet(context, product.description);
                },
                child: Text(
                  "Xem chi tiết",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                      fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildComments(BuildContext context, List<Comment> listComment) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.black12),
          bottom: BorderSide(width: 1.0, color: Colors.black12),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Phản hồi",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
                Text(
                  "Bình luận",
                  style: TextStyle(fontSize: 18.0, color: Colors.blue),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                StarRating(rating: 40, size: 20),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "${listComment.length} đánh giá",
                  style: TextStyle(color: Colors.black54),
                )
              ],
            ),
            SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                controller: ScrollController(keepScrollOffset: false),
                itemCount: listComment.length,
                itemBuilder: (context, pos) {
                  return Column(
                    children: [
                      SizedBox(
                        child: Divider(
                          color: Colors.black26,
                          height: 4,
                        ),
                        height: 24,
                      ),
                      ListTile(
                        leading: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: ClipOval(
                            child: FadeInImage.assetNetwork(
                              placeholder: "assets/Spinner.gif",
                              image: listComment[pos].image == null
                                  ? "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/User_font_awesome.svg/768px-User_font_awesome.svg.png"
                                  : "http://192.168.100.18/AppStore/public/layout/images/avatarClient/${listComment[pos].image}",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        subtitle: Text(listComment[pos].content),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              listComment[pos].name,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              listComment[pos].createdAt,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildProducts(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Similar Items",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54),
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: ProductListPage(),
                      ),
                    );
                  },
                  child: Text(
                    "Xem trọn bộ",
                    style: TextStyle(fontSize: 18.0, color: Colors.blue),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
        ),
        buildTrending()
      ],
    );
  }

  Column buildTrending() {
    return Column(
      children: <Widget>[
        Container(
          height: 200,
          child: ListView(
              scrollDirection: Axis.horizontal,
              children: listMore
                  .map(
                    (e) => TrendingItem(
                      product: Product(
                        id: e.id,
                        company: e.company,
                        name: e.name,
                        icon: e.icon,
                        rating: 4.5,
                        remainingQuantity: e.remainingQuantity,
                        price: e.price,
                        sale: e.sale,
                      ),
                      gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
                    ),
                  )
                  .toList()),
        )
      ],
    );
  }
}

void _settingModalBottomSheet(context, String description) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Mô tả",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SingleChildScrollView(
                      child: Column(children: [
                    Html(
                      data: """$description""",
                    ),
                  ])),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

class AddItem extends StatelessWidget {
  final Product product;

  const AddItem({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        print("state:              $state");
        if (state is CartLoading) {
          return const CircularProgressIndicator();
        }
        if (state is CartLoaded) {
          return RaisedButton(
            onPressed: () {
              alert(context);
              // setState(() {
              //   isClicked = !isClicked;
              // });
              context.read<CartBloc>().add(CartItemAdded(Item(
                  //       product: Product(
                  id: product.id,
                  company: product.company,
                  name: product.name,
                  icon: product.icon,
                  rating: 4.5,
                  remainingQuantity: product.remainingQuantity,
                  price: product.price,
                  sale: product.sale,
                  // ),
                  qty: 1)));
            },
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width / 2.9,
              height: 60,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    CustomColors.GreenLight,
                    CustomColors.GreenDark,
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: CustomColors.GreenShadow,
                    blurRadius: 15.0,
                    spreadRadius: 7.0,
                    offset: Offset(0.0, 0.0),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    MaterialCommunityIcons.getIconData(
                      "cart-outline",
                    ),
                    color: Colors.white,
                  ),
                  new Text(
                    "Thêm vào giỏ",
                    style: TextStyle(color: Colors.white),
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

  alert(BuildContext context) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.shrink,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Color.fromRGBO(0, 179, 134, 1.0),
      ),
    );
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.success,
      title: "Giỏ hàng",
      desc: "Sản phẩm ${product.name} đã được thêm vào giỏ.",
      buttons: [
        DialogButton(
          child: Text(
            "Quay lại",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "Xem giỏ",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ShoppingCart(true),
            ));
            Navigator.of(context, rootNavigator: true).pop();
          },
          // Navigator.push(
          //   context,
          //   PageTransition(
          //     type: PageTransitionType.fade,
          //     child: ShoppingCart(true),
          //   ),
          // ),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }
}
