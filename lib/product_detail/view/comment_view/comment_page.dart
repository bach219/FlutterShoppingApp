import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/product_detail/bloc/comment_bloc/comment_bloc.dart';
import 'comment_view.dart';

class CommentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CommentBloc(),
      child: Comment(),
    );
  }
}
