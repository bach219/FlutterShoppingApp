import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/product_detail/bloc/product_detail_bloc/product_detail.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttercommerce/models/product.dart';
import 'product_detail_view.dart';
import 'package:flutter/foundation.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  ProductDetailPage({Key key, @required this.product}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductDetailBloc()..add(DataFetched()),
      child: ProductPage(),
    );
  }
}
