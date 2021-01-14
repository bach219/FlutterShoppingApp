// import 'dart:async';
// import 'package:hive/hive.dart';
// import 'package:fluttercommerce/authentication/authentication.dart';
// import 'package:formz/formz.dart';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'dart:core';
// import 'dart:convert';
// import 'package:fluttercommerce/Repository/repository.dart';
// import 'package:fluttercommerce/cart/models/models.dart';
// import 'package:pedantic/pedantic.dart';
// part 'order_event.dart';
// part 'order_state.dart';

// class OrderBloc extends Bloc<OrderEvent, OrderState> {
//   OrderBloc() : super(OrderLoading());

//   @override
//   Stream<OrderState> mapEventToState(
//     OrderEvent event,
//   ) async* {
//     if (event is SignUpPasswordChanged) {
//       yield _mapPasswordChangedToState(event, state);
//     } else if (event is SignUpPasswordVerifyChanged) {
//       yield _mapPasswordVerifyChangedToState(event, state);
//     } else if (event is SignUpAddressChanged) {
//       yield _mapAddressChangedToState(event, state);
//     }
//   }

  
// }
