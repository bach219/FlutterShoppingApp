import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/product_detail/bloc/product_detail_bloc/product_detail.dart';
import 'package:fluttercommerce/cart/bloc/cart.dart';

import 'package:flutter/widgets.dart';
import 'product_detail_view.dart';

class ProductDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CartBloc>(
            create: (_) => CartBloc()..add(CartStarted()),
          ),
          BlocProvider<ProductDetailBloc>(
            create: (_) => ProductDetailBloc()..add(DataFetched()),
          ),
        ],
        child: MaterialApp(
          home: ProductPage(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            dividerColor: Color(0xFFECEDF1),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            primaryColor: Color(0xFFDBCC8F),
            accentColor: Colors.cyan[600],
            fontFamily: 'Montserrat',
            textTheme: TextTheme(
              headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              title: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              subtitle: TextStyle(fontSize: 16),
              body1: TextStyle(fontSize: 14.0, fontFamily: 'Montserrat'),
              display1: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Montserrat1',
                  color: Colors.white),
              display2: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Montserrat',
                  color: Colors.black54),
            ),
          ),
        )
        // ProductPage()
        );

    // BlocProvider(
    //   create: (_) => ProductDetailBloc()..add(DataFetched()),
    //   child: ProductPage(),
    // );
  }
}
