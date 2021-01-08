import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/home/bloc/home_bloc/home_bloc.dart';
import 'home_view.dart';
import 'package:fluttercommerce/cart/bloc/cart.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CartBloc>(
            create: (_) => CartBloc()..add(CartStarted()),
          ),
          BlocProvider<HomeBloc>(
            create: (_) => HomeBloc()..add(DataFetched()),
          ),
        ],
        child: MaterialApp(
          home: Home(),
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

    // return BlocProvider(
    //   create: (_) => HomeBloc()..add(DataFetched()),
    //   child: Home(),
    // );
  }
}
