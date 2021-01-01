import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/home/bloc/best_expensive_phone_bloc/best_expensive_phone.dart';
import 'best_expensive_phone_view.dart';

class BestExpensiveProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BestExpensivePhoneBloc()..add(DataFetched()),
      child: BestExpensivePhone(),
    );
  }
}
