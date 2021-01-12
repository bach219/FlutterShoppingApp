import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/checkout/bloc/checkout_bloc.dart';
import 'checkout_view.dart';

class CheckOutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CheckOutBloc()..add(DataFetched()),
      child: Checkout(),
    );
  }
}
