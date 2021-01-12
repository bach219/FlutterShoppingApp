import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/product_list/bloc/list_product_bloc/list_product.dart';
import 'list_product_view.dart';

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ListProductBloc()..add(ListProductStarted()),
      child: ProductList(),
    );
  }
}
