import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/product_detail/bloc/product_detail_bloc/product_detail.dart';
import 'package:fluttercommerce/cart/bloc/cart.dart';
import 'package:hive/hive.dart';
import 'package:flutter/widgets.dart';
import 'product_detail_view.dart';
import 'package:fluttercommerce/cart/models/models.dart';

class ProductDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductDetailBloc()..add(DataFetched()),
      child: ProductPage(),
    );
  }
}
