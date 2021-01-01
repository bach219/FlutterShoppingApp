import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/home/bloc/list_new_product_bloc/list_new_product.dart';
import 'list_new_product_view.dart';

class ListNewProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ListProductBloc()..add(DataFetched()),
      child: ListNewProduct(),
    );
  }
}
