import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/authentication/authentication.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttercommerce/screens/products_list.dart';
import 'package:fluttercommerce/screens/usersettings.dart';
import 'package:fluttercommerce/screens/whell.dart';
import 'package:fluttercommerce/utils/constant.dart';
import 'package:fluttercommerce/utils/navigator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttercommerce/screens/screens.dart';
import 'package:fluttercommerce/home/bloc/home_bloc/home_bloc.dart';
import '../../home.dart';
import 'home_page.dart';
import 'package:fluttercommerce/models/models.dart';
import 'package:fluttercommerce/product_list/view/product_list_view.dart';
import 'package:fluttercommerce/search/view/search_page.dart';
import 'package:fluttercommerce/cart/view/cart_view.dart';
import 'package:fluttercommerce/cart/bloc/cart.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  User client = User.empty;
  double widget1Opacity = 0.0;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 30), () {
      widget1Opacity = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.status) {
          case HomeStatus.failure:
            // return const Center(child: Text('failed to fetch posts'));
            return const Center(child: CircularProgressIndicator());
          case HomeStatus.initial:
            return Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 11,
                child: Center(child: Image.asset("assets/Spinner.gif")));
          case HomeStatus.success:
            client = state.client;
            return DefaultTabController(
              length: 4,
              child: Scaffold(
                backgroundColor: Colors.white,
                key: _scaffoldKey,
                drawer: Drawer(child: leftDrawerMenu()),
                appBar: buildAppBar(context),
                bottomNavigationBar: new TabBar(
                  tabs: [
                    Tab(
                      icon: new Icon(Icons.home),
                    ),
                    Tab(
                      icon: new Icon(Icons.attach_money),
                    ),
                    Tab(
                      icon: new Icon(Icons.shopping_cart),
                    ),
                    Tab(
                      icon: new Icon(Icons.account_circle),
                    )
                  ],
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.blueGrey,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding: EdgeInsets.all(8.0),
                  indicatorColor: Colors.black,
                ),
                //Thanh BAR nam duoi
                body: TabBarView(
                  children: [
                    Container(
                        child: AnimatedOpacity(
                      opacity: widget1Opacity,
                      duration: Duration(seconds: 1),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            ListFunctionalityPage(),
                            buildCarouselSlider(),
                            SizedBox(
                              height: 5.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "Nổi bật",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
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
                                        style: TextStyle(
                                            fontSize: 18.0, color: Colors.blue),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListNewProductPage(),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "Bán chạy",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
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
                                        style: TextStyle(
                                            fontSize: 18.0, color: Colors.blue),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListSellProductPage(),
                            BestSellProductPage(),
                            BestExpensiveProductPage(),
                          ],
                        ),
                      ),
                    )),
                    WhellFortune(),
                    ShoppingCart(false),
                    UserSettings(),
                  ],
                ),
              ),
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  //Ảnh chạy
  CarouselSlider buildCarouselSlider() {
    return CarouselSlider(
      height: 150,
      viewportFraction: 0.9,
      aspectRatio: 16 / 9,
      autoPlay: true,
      enlargeCenterPage: true,
      items: imgList.map(
        (url) {
          return Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    width: 1000.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Bach\'s Shop",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("Luôn sẵn sàng tư vấn bạn.",
                            style:
                                TextStyle(color: Colors.white, fontSize: 14)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ).toList(),
    );
  }

  BottomNavyBar buildBottomNavyBar(BuildContext context) {
    return BottomNavyBar(
      selectedIndex: currentIndex,
      showElevation: true,
      onItemSelected: (index) => setState(() {
        currentIndex = index;
      }),
      items: [
        BottomNavyBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
          activeColor: Theme.of(context).primaryColor,
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Categories'),
            activeColor: Theme.of(context).primaryColor),
        BottomNavyBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Shopping Cart'),
            activeColor: Theme.of(context).primaryColor),
        BottomNavyBarItem(
            icon: Icon(Icons.shopping_basket),
            title: Text('Orders'),
            activeColor: Theme.of(context).primaryColor),
      ],
    );
  }

  //Thanh BAR ngang tim kiem
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Bach\'s Shop",
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
      leading: new IconButton(
          icon: new Icon(MaterialCommunityIcons.getIconData("menu"),
              color: Colors.black),
          onPressed: () async {
            _scaffoldKey.currentState.openDrawer();
          }),
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
      ],
      backgroundColor: Color(0xFFDBCC8F),
    );
  }

// SIDEBARRRRR o dayyyyyyyy
  leftDrawerMenu() {
    Color blackColor = Colors.black.withOpacity(0.6);
    return Container(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            height: 150,
            // client icon
            child: DrawerHeader(
              child: ListTile(
                trailing: Icon(
                  Icons.chevron_right,
                  size: 28,
                ),
                subtitle: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: UserSettings(),
                      ),
                    );
                  },
                  child: Text(
                    "See Profile",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: blackColor),
                  ),
                ),
                title: Text(
                  client.name.toString(),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: blackColor),
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "http://192.168.100.18/AppStore/public/layout/images/avatarClient/${client.photo}"),
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xFFF8FAFB),
              ),
            ),
          ),
          // Setting
          ListTile(
            leading: Icon(
              Feather.getIconData('home'),
              color: blackColor,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: blackColor),
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
          ListTile(
            trailing: Icon(
              Ionicons.getIconData('ios-radio-button-on'),
              color: Color(0xFFFB7C7A),
              size: 18,
            ),
            leading: Icon(Feather.getIconData('gift'), color: blackColor),
            title: Text('Wheel Spin(Free)',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: WhellFortune(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Feather.getIconData('search'), color: blackColor),
            title: Text('Search',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: SearchPage(),
                ),
              );
            },
          ),
          ListTile(
            trailing: Icon(
              Ionicons.getIconData('ios-radio-button-on'),
              color: Color(0xFFFB7C7A),
              size: 18,
            ),
            leading: Icon(Feather.getIconData('bell'), color: blackColor),
            title: Text('Notifications',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () {
              Nav.route(context, Checkout());
            },
          ),
          ListTile(
            trailing: Icon(
              Icons.looks_two,
              color: Color(0xFFFB7C7A),
              size: 18,
            ),
            leading:
                Icon(Feather.getIconData('shopping-cart'), color: blackColor),
            title: Text('Shopping Cart',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: ShoppingCart(true),
                ),
              );
            },
          ),
          // ListTile(
          //   leading: Icon(Feather.getIconData('list'), color: blackColor),
          //   title: Text('My Orders',
          //       style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.w600,
          //           color: blackColor)),
          //   onTap: () {
          //     Nav.route(context, ProductList());
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Feather.getIconData('award'), color: blackColor),
          //   title: Text('Points',
          //       style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.w600,
          //           color: blackColor)),
          //   onTap: () {
          //     Nav.route(context, Checkout());
          //   },
          // ),
          // ListTile(
          //   leading:
          //       Icon(Feather.getIconData('message-circle'), color: blackColor),
          //   title: Text('Support',
          //       style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.w600,
          //           color: blackColor)),
          //   onTap: () {
          //     Nav.route(context, ProductList());
          //   },
          // ),
          ListTile(
            leading:
                Icon(Feather.getIconData('help-circle'), color: blackColor),
            title: Text('Help',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () {
              Nav.route(context, UserSettings());
            },
          ),
          ListTile(
            leading: Icon(Feather.getIconData('settings'), color: blackColor),
            title: Text('Settings',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: UserSettings(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Feather.getIconData('log-out'), color: blackColor),
            title: Text('Logout',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested());
            },
          ),
          ListTile(
            leading: Icon(Feather.getIconData('x-circle'), color: blackColor),
            title: Text('Quit',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
          ),
        ],
      ),
    );
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
            left: 5,
            bottom: 10,
            child: state.cart.totalLength > 0
                ? Text(state.cart.totalLength.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        height: 5,
                        fontSize: 12))
                : Text(""));
      }
      return const Text('Something went wrong!');
    });
  }
}
