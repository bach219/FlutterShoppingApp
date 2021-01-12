import 'dart:async';
import 'package:hive/hive.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:core';
import 'dart:convert';
import 'package:fluttercommerce/Repository/repository.dart';
import 'package:fluttercommerce/models/user.dart';
import 'package:pedantic/pedantic.dart';
part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckOutBloc extends Bloc<CheckOutEvent, CheckOutState> {
  CheckOutBloc() : super(const CheckOutState());

  @override
  Stream<CheckOutState> mapEventToState(CheckOutEvent event) async* {
    if (event is DataFetched) {
      yield await _mapCheckOutFetchedToState(state);
    }
  }

  // ignore: missing_return
  Future<CheckOutState> _mapCheckOutFetchedToState(CheckOutState state) async {
    try {
      if (state.status == CheckOutStatus.initial) {
        final User client = await UserRepository().getUser();
        return state.copyWith(
          status: CheckOutStatus.initial,
          client: client,
        );
      }
    } on Exception {
      return state.copyWith(status: CheckOutStatus.failure);
    }
  }
}
