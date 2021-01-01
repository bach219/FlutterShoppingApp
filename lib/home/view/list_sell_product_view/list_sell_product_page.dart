import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/home/bloc/list_sell_product_bloc/list_sell_product_bloc.dart';
import 'list_sell_product_view.dart';

class ListSellProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ListProductBloc()..add(DataFetched()),
      child: ListSellProduct(),
    );
  }
}
