import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/login/login.dart';
import 'package:fluttercommerce/sign_up/sign_up.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                    content: Text(
                        'Đăng nhập thất bại! Vui lòng kiểm tra lại tài khoản!')),
              );
          }
        },
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      "Bach\'s Shop",
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text("Đăng nhập tài khoản của bạn",
                          style: Theme.of(context).textTheme.subtitle),
                    ),
                    _EmailInput(),
                    _PasswordInput(),
                    _LoginButton(),
                    // Padding(
                    //   padding: const EdgeInsets.all(32.0),
                    //   child: Text("Forgot your password?"),
                    // ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Bạn chưa có tài khoản?  ",
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push<void>(SignUpPage.route());
                          },
                          child: Text(
                            "Đăng ký",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 60, bottom: 8.0, left: 24.0, right: 24.0),
              child: TextField(
                key: const Key('loginForm_emailInput_textField'),
                onChanged: (email) =>
                    context.read<LoginBloc>().add(LoginEmailChanged(email)),
                textAlign: TextAlign.left,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: Theme.of(context).dividerColor,
                  // hintText: "Email",
                  hintStyle: Theme.of(context).textTheme.display2,
                  labelText: "Địa chỉ Email",
                  errorText: state.email.invalid ? 'Sai định dạng email' : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
          );
        });
  }
}

class _PasswordInput extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 8.0, left: 24.0, right: 24.0),
              child: TextField(
                key: const Key('loginForm_passwordInput_textField'),
                obscureText: true,
                onChanged: (password) => context
                    .read<LoginBloc>()
                    .add(LoginPasswordChanged(password)),
                textAlign: TextAlign.left,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  fillColor: Theme.of(context).dividerColor,
                  // hintText: "Password",
                  hintStyle: Theme.of(context).textTheme.display2,
                  labelText: "Mật khẩu",
                  errorText: state.password.invalid
                      ? 'Mật khẩu phải có ít nhất 6 kí tự'
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
          );
        });
  }
}

class _LoginButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? const CircularProgressIndicator()
              : Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 24.0, right: 24.0, bottom: 20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new FlatButton(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              color: Theme.of(context).primaryColor,
                              onPressed: state.status.isValidated
                                  ? () {
                                      context
                                          .read<LoginBloc>()
                                          .add(const LoginSubmitted());
                                    }
                                  : null,
                              child: new Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 10.0,
                                ),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Expanded(
                                      child: Text(
                                        "Đăng nhập",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
