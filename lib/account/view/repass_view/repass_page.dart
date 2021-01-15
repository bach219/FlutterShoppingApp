import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/account/bloc/account_bloc.dart';
import 'repass_view.dart';

class RepassPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RepassBloc(),
      child: ChangPassword(),
    );
  }
}
