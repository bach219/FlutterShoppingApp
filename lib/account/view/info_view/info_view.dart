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

class Information extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InfoBloc, InfoState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                    content: Text(
                        'Đã xảy ra sự cố! Không thể tải dữ liệu cá nhân :(')),
              );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Thông tin cá nhân",
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
                        _NameInput(),
                        _SexInput(),
                        _AddressInput(),
                        _EmailInput(),
                        _PhoneInput(),
                        _InfoButton()
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

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoBloc, InfoState>(
        buildWhen: (previous, current) =>
            previous.email != current.email ||
            previous.status != current.status,
        builder: (context, state) {
          TextEditingController _textEditingController =
              TextEditingController(text: state.client.email);
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
              key: const Key('infoForm_emailInput_textField'),
              // controller: TextEditingController(text: state.email.value),
              controller: new TextEditingController.fromValue(
                  new TextEditingValue(
                      text: state.email.value,
                      selection: new TextSelection.collapsed(
                          offset: state.email.value.length))),
              // initialValue: _textEditingController.text,
              onChanged: (email) {
                context.read<InfoBloc>().add(InfoEmailChanged(email));
              },
              // controller: _textController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              maxLines: null,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF10CA88), width: 5)),
                labelStyle: TextStyle(color: Color(0xFF4CD7A5)),
                labelText: "Địa chỉ Email",
                errorText: state.email.invalid ? 'Sai định dạng Email' : null,
                hintStyle: TextStyle(fontSize: 16),
                filled: true,
                prefixIcon: Icon(
                  Icons.email,
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

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoBloc, InfoState>(
        buildWhen: (previous, current) =>
            previous.name != current.name || previous.status != current.status,
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
              key: const Key('infoForm_nameInput_textField'),
              // initialValue: state.client.name,
              // controller: TextEditingController(text: state.name.value),
              controller: new TextEditingController.fromValue(
                  new TextEditingValue(
                      text: state.name.value,
                      selection: new TextSelection.collapsed(
                          offset: state.name.value.length))),

              onChanged: (name) =>
                  context.read<InfoBloc>().add(InfoNameChanged(name)),
              // controller: _textController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              maxLines: null,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF10CA88), width: 5)),
                labelStyle: TextStyle(color: Color(0xFF10CA88)),
                labelText: "Tên giao dịch",
                errorText:
                    state.name.invalid ? 'Tên đăng nhập bị bỏ trống' : null,
                hintStyle: TextStyle(fontSize: 16),
                filled: true,
                prefixIcon: Icon(
                  Icons.supervisor_account,
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

class _AddressInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoBloc, InfoState>(
        buildWhen: (previous, current) =>
            previous.address != current.address ||
            previous.status != current.status,
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
              key: const Key('infoForm_addressInput_textField'),
              onChanged: (address) =>
                  context.read<InfoBloc>().add(InfoAddressChanged(address)),
              // initialValue: state.client.address,
              // controller: TextEditingController(text: state.address.value),
              controller: new TextEditingController.fromValue(
                  new TextEditingValue(
                      text: state.address.value,
                      selection: new TextSelection.collapsed(
                          offset: state.address.value.length))),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              maxLines: null,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF10CA88), width: 5)),
                labelStyle: TextStyle(color: Color(0xFF4CD7A5)),
                labelText: "Địa chỉ giao hàng",
                errorText: state.address.invalid
                    ? 'Địa chỉ giao hàng bị bỏ trống'
                    : null,
                hintStyle: TextStyle(fontSize: 16),
                filled: true,
                prefixIcon: Icon(
                  Icons.home,
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

class _PhoneInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoBloc, InfoState>(
        buildWhen: (previous, current) =>
            previous.phone != current.phone ||
            previous.status != current.status,
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
              key: const Key('infoForm_phoneInput_textField'),
              onChanged: (phone) =>
                  context.read<InfoBloc>().add(InfoPhoneChanged(phone)),
              // initialValue: state.client.phone,
              // controller: TextEditingController(text: state.phone.value),
              controller: new TextEditingController.fromValue(
                  new TextEditingValue(
                      text: state.phone.value,
                      selection: new TextSelection.collapsed(
                          offset: state.phone.value.length))),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLines: null,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF10CA88), width: 5)),
                labelStyle: TextStyle(color: Color(0xFF4CD7A5)),
                labelText: "Số điện thoại",
                errorText:
                    state.phone.invalid ? 'Số điện thoại không đúng' : null,
                hintStyle: TextStyle(fontSize: 16),
                filled: true,
                prefixIcon: Icon(
                  Icons.phone,
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

class _SexInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoBloc, InfoState>(
        buildWhen: (previous, current) =>
            previous.sex != current.sex || previous.status != current.status,
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
              key: const Key('infoForm_sexInput_textField'),
              onChanged: (sex) =>
                  context.read<InfoBloc>().add(InfoSexChanged(sex)),
              // initialValue:  state.sex.value,
              // controller: TextEditingController(text: state.sex.value),
              controller: new TextEditingController.fromValue(
                  new TextEditingValue(
                      text: state.sex.value,
                      selection: new TextSelection.collapsed(
                          offset: state.sex.value.length))),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              maxLines: null,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF10CA88), width: 5)),
                labelStyle: TextStyle(color: Color(0xFF4CD7A5)),
                labelText: "Giới tính",
                errorText: state.sex.invalid ? 'Nam | Nữ' : null,
                hintStyle: TextStyle(fontSize: 16),
                filled: true,
                prefixIcon: Icon(
                  Icons.supervised_user_circle,
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

class _InfoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoBloc, InfoState>(
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
                            context.read<InfoBloc>().add(const InfoSubmitted());
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

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      print("state:              $state");
      if (state is CartLoading) {
        return const CircularProgressIndicator();
      }
      if (state is CartLoaded) {
        return Positioned(
            left: 5,
            bottom: 10,
            child: state.cart.totalLength > 0
                ? Text(state.cart.totalLength.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        height: 5,
                        fontSize: 12))
                : Text(""));
      }
      return const Text('Something went wrong!');
    });
  }
}
