import 'package:flutter/material.dart';
import 'package:flutter_icons/ionicons.dart';
import 'package:fluttercommerce/home/view/home_view/home_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:hive/hive.dart';
import 'dart:convert';
import 'package:fluttercommerce/checkout/bloc/checkout_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/cart/models/models.dart';
import 'package:fluttercommerce/Repository/repository.dart';
import 'package:fluttercommerce/cart/bloc/cart.dart';
import 'package:fluttercommerce/account/bloc/account_bloc.dart';
import 'package:formz/formz.dart';

class ChangPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RepassBloc, RepassState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Mật khẩu hiện tại chưa đúng :(')),
              );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Thay đổi mật khẩu",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            leading: IconButton(
              icon: Icon(Ionicons.getIconData("ios-arrow-back"),
                  color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            backgroundColor: Color(0xFFDBCC8F),
          ),
          body: Center(
            child: Container(
              padding: EdgeInsets.only(
                  top: 12.0, left: 12.0, right: 12.0, bottom: 12.0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Card(
                elevation: 6.0,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _OldPasswordInput(),
                        _NewPasswordInput(),
                        _ConfirmPasswordInput(),
                        _RepassButton()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

class _OldPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepassBloc, RepassState>(
        buildWhen: (previous, current) =>
            previous.nowPassword != current.nowPassword,
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Color(0xFFE7F9F5),
              border: Border.all(
                color: Color(0xFF4CD7A5),
              ),
            ),
            child: TextFormField(
              key: const Key('repassForm_nowPasswordInput_textField'),
              onChanged: (nowPassword) {
                context
                    .read<RepassBloc>()
                    .add(RepassPasswordNowChanged(nowPassword));
              },
              // controller: _textController,
              obscureText: true,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF10CA88), width: 5)),
                labelStyle: TextStyle(color: Color(0xFF4CD7A5)),
                labelText: "Mật khẩu cũ",
                errorText: state.nowPassword.invalid
                    ? 'Mật khẩu phải có ít nhất 6 kí tự'
                    : null,
                hintStyle: TextStyle(fontSize: 16),
                filled: true,
                prefixIcon: Icon(
                  Icons.code,
                  color: Color(0xFF10CA88),
                ),
                suffixIcon: Icon(
                  Icons.check_circle,
                  color: Color(0xFF10CA88),
                ),
              ),
            ),
          );
        });
  }
}

class _NewPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepassBloc, RepassState>(
        buildWhen: (previous, current) =>
            previous.newPassword != current.newPassword,
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Color(0xFFE7F9F5),
              border: Border.all(
                color: Color(0xFF4CD7A5),
              ),
            ),
            child: TextFormField(
              key: const Key('repassForm_newPasswordInput_textField'),
              onChanged: (nowPassword) {
                context
                    .read<RepassBloc>()
                    .add(RepassPasswordNewChanged(nowPassword));
              },
              // controller: _textController,
              obscureText: true,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF10CA88), width: 5)),
                labelStyle: TextStyle(color: Color(0xFF4CD7A5)),
                labelText: "Mật khẩu mới",
                errorText: state.nowPassword.invalid
                    ? 'Mật khẩu phải có ít nhất 6 kí tự'
                    : null,
                hintStyle: TextStyle(fontSize: 16),
                filled: true,
                prefixIcon: Icon(
                  Icons.code,
                  color: Color(0xFF10CA88),
                ),
                suffixIcon: Icon(
                  Icons.check_circle,
                  color: Color(0xFF10CA88),
                ),
              ),
            ),
          );
        });
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepassBloc, RepassState>(
        buildWhen: (previous, current) =>
            previous.passwordVerify != current.passwordVerify ||
            previous.newPassword != current.newPassword,
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Color(0xFFE7F9F5),
              border: Border.all(
                color: Color(0xFF4CD7A5),
              ),
            ),
            child: TextFormField(
              key: const Key('repassForm_passwordVerifyInput_textField'),
              onChanged: (passwordVerify) {
                context
                    .read<RepassBloc>()
                    .add(RepassPasswordVerifyChanged(passwordVerify));
              },
              obscureText: true,
              // controller: _textController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF10CA88), width: 5)),
                labelStyle: TextStyle(color: Color(0xFF4CD7A5)),
                labelText: "Xác nhận mật khẩu mới",
                errorText: state.passwordVerify.invalid
                    ? 'Xác nhận mật khẩu chưa đúng'
                    : null,
                hintStyle: TextStyle(fontSize: 16),
                filled: true,
                prefixIcon: Icon(
                  Icons.confirmation_num,
                  color: Color(0xFF10CA88),
                ),
                suffixIcon: Icon(
                  Icons.check_circle,
                  color: Color(0xFF10CA88),
                ),
              ),
            ),
          );
        });
  }
}

class _RepassButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepassBloc, RepassState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? Center(
                  child: const CircularProgressIndicator(
                    backgroundColor: Color(0xFFDBCC8F),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              // : state.status.isSubmissionFailure
              //     ? Center(
              //         child: const CircularProgressIndicator(
              //           backgroundColor: Color(0xFFDBCC8F),
              //           valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              //         ),
              //       )
              : Container(
                  margin: EdgeInsets.only(top: 24.0),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    color: Color(0xFFDBCC8F),
                    onPressed: state.status.isValidated
                        ? () {
                            context
                                .read<RepassBloc>()
                                .add(const RepassSubmitted());
                          }
                        : null,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 10.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Cập nhật",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        });
  }
}
