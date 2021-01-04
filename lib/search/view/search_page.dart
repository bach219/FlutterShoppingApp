import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/search/bloc/search.dart';
import 'search_view.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    BlocProvider(
      create: (_) => SearchBloc()..add(DataFetched()),
      child: Search(),
    );
  }
}
