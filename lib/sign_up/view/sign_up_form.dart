import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercommerce/sign_up/sign_up.dart';
import 'package:fluttercommerce/login/login.dart';
import 'package:formz/formz.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                    content: Text(
                        'Đăng ký thất bại!Thông tin có lẽ đã được đăng ký trước đó!')),
              );
          }
        },
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Bach\'s Shop",
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 32.0),
                      child: Text(
                        "Đăng ký tài khoản",
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                    ),
                    _SexInput(),
                    _NameInput(),
                    _PasswordInput(),
                    _ConfirmPasswordInput(),
                    _AddressInput(),
                    _EmailInput(),
                    _PhoneInput(),
                    _SignUpButton(),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Bạn đã có tài khoản? ",
                            style: TextStyle(fontSize: 17),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push<void>(LoginPage.route());
                            },
                            child: Text(
                              "Đăng nhập",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 17),
                            ),
                          ),
                        ],
                      ),
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
    return BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return Container(
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 24.0, right: 24.0),
              child: TextField(
                key: const Key('signupForm_emailInput_textField'),
                onChanged: (email) =>
                    context.read<SignUpBloc>().add(SignUpEmailChanged(email)),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: Theme.of(context).dividerColor,
                  hintText: "abc@gmail.com",
                  hintStyle: Theme.of(context).textTheme.display2,
                  labelText: "Địa chỉ Email",
                  icon: const Icon(Icons.email),
                  errorText: state.email.invalid ? 'Sai định dạng Email' : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  // prefixIcon: Icon(
                  //   Icons.email,
                  //   color: Colors.black,
                  // ),
                ),
              ),
            ),
          );
        });
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return Container(
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 24.0, right: 24.0),
              child: TextField(
                key: const Key('signupForm_passwordInput_textField'),
                obscureText: true,
                onChanged: (password) => context
                    .read<SignUpBloc>()
                    .add(SignUpPasswordChanged(password)),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  icon: const Icon(Icons.code),
                  fillColor: Theme.of(context).dividerColor,
                  hintStyle: Theme.of(context).textTheme.display2,
                  labelText: "Mật khẩu",
                  hintText: "******",
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
                  // prefixIcon: Icon(
                  //   Icons.code,
                  //   color: Colors.black,
                  // ),
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
    return BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: (previous, current) =>
            previous.passwordVerify != current.passwordVerify ||
            previous.password != current.password,
        builder: (context, state) {
          return Container(
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 24.0, right: 24.0),
              child: TextField(
                key: const Key('signupForm_passwordVerifyInput_textField'),
                obscureText: true,
                onChanged: (passwordVerify) => context
                    .read<SignUpBloc>()
                    .add(SignUpPasswordVerifyChanged(passwordVerify)),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  fillColor: Theme.of(context).dividerColor,
                  hintText: "******",
                  icon: const Icon(Icons.confirmation_num),
                  hintStyle: Theme.of(context).textTheme.display2,
                  labelText: "Xác nhận mật khẩu",
                  errorText: state.passwordVerify.invalid
                      ? 'Xác nhận mật khẩu chưa đúng'
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
                  // prefixIcon: Icon(
                  //   Icons.confirmation_num,
                  //   color: Colors.black,
                  // ),
                ),
              ),
            ),
          );
        });
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: (previous, current) => previous.name != current.name,
        builder: (context, state) {
          return Container(
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 24.0, right: 24.0),
              child: TextField(
                key: const Key('signupForm_nameInput_textField'),
                onChanged: (name) =>
                    context.read<SignUpBloc>().add(SignUpNameChanged(name)),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  fillColor: Theme.of(context).dividerColor,
                  hintText: "ABC",
                  icon: const Icon(Icons.supervisor_account),
                  hintStyle: Theme.of(context).textTheme.display2,
                  labelText: "Tên đăng nhập",
                  errorText:
                      state.name.invalid ? 'Tên đăng nhập bị bỏ trống' : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  // prefixIcon: Icon(
                  //   Icons.supervisor_account,
                  //   color: Colors.black,
                  // ),
                ),
              ),
            ),
          );
        });
  }
}

class _AddressInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: (previous, current) => previous.address != current.address,
        builder: (context, state) {
          return Container(
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 24.0, right: 24.0),
              child: TextField(
                key: const Key('signupForm_addressInput_textField'),
                onChanged: (address) => context
                    .read<SignUpBloc>()
                    .add(SignUpAddressChanged(address)),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  fillColor: Theme.of(context).dividerColor,
                  hintText: "Hà Nội",
                  icon: const Icon(Icons.house),
                  hintStyle: Theme.of(context).textTheme.display2,
                  labelText: "Địa chỉ giao hàng",
                  errorText: state.address.invalid
                      ? 'Địa chỉ giao hàng bị bỏ trống'
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
                  // prefixIcon: Icon(
                  //   Icons.house,
                  //   color: Colors.black,
                  // ),
                ),
              ),
            ),
          );
        });
  }
}

class _PhoneInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: (previous, current) => previous.phone != current.phone,
        builder: (context, state) {
          return Container(
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 24.0, right: 24.0),
              child: TextField(
                key: const Key('signupForm_phoneInput_textField'),
                onChanged: (phone) =>
                    context.read<SignUpBloc>().add(SignUpPhoneChanged(phone)),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: Theme.of(context).dividerColor,
                  hintText: "0333******",
                  icon: const Icon(Icons.phone),
                  hintStyle: Theme.of(context).textTheme.display2,
                  labelText: "Số điện thoại",
                  errorText:
                      state.phone.invalid ? 'Số điện thoại không đúng' : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  // prefixIcon: Icon(
                  //   Icons.contact_phone,
                  //   color: Colors.black,
                  // ),
                ),
              ),
            ),
          );
        });
  }
}

class _SexInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: (previous, current) => previous.sex != current.sex,
        builder: (context, state) {
          return Container(
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 24.0, right: 24.0),
              child: TextField(
                key: const Key('signupForm_sexInput_textField'),
                onChanged: (sex) =>
                    context.read<SignUpBloc>().add(SignUpSexChanged(sex)),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  fillColor: Theme.of(context).dividerColor,
                  hintText: "Nam",
                  icon: const Icon(Icons.supervised_user_circle),
                  hintStyle: Theme.of(context).textTheme.display2,
                  labelText: "Giới tính",
                  errorText: state.sex.invalid ? 'Nam | Nữ' : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  // prefixIcon: Icon(
                  //   Icons.supervised_user_circle,
                  //   color: Colors.black,
                  // ),
                ),
              ),
            ),
          );
        });
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? const CircularProgressIndicator(
                  backgroundColor: Color(0xFFDBCC8F),
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 5.0, left: 24.0, right: 24.0),
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
                                          .read<SignUpBloc>()
                                          .add(const SignUpSubmitted());
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
                                        "Đăng ký",
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
