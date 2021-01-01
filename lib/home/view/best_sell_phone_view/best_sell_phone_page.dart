import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/home/bloc/best_sell_phone_bloc/best_sell_phone.dart';
import 'best_sell_phone_view.dart';

class BestSellProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BestSellPhoneBloc()..add(DataFetched()),
      child: BestSellPhone(),
    );
  }
}
