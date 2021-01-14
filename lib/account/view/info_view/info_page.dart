import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/account/bloc/account_bloc.dart';
import 'info_view.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InfoBloc()..add(InfoStarted()),
      child: Information(),
    );
  }
}
