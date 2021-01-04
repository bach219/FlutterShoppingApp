import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/product_detail/bloc/image_detail_bloc/image_detail.dart';
import 'package:flutter/widgets.dart';
import 'image_detail_view.dart';

class ImageDetailPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ImageDetailBloc()..add(DataFetched()),
      child: ImagePage(),
    );
  }
}
