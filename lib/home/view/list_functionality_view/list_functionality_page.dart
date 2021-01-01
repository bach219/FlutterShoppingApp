import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/home/bloc/list_functionality_bloc/list_functionality.dart';
import 'list_functionality_view.dart';

class ListFunctionalityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ListFunctionalityBloc()..add(DataFetched()),
      child: ListFunctionality(),
    );
  }
}
