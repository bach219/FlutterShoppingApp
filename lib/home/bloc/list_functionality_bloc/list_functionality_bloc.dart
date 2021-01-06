import 'dart:async';
import 'dart:convert';
import 'package:fluttercommerce/Repository/UserRepository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttercommerce/models/models.dart';
import 'package:fluttercommerce/network/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:core';
import 'package:fluttercommerce/login/login.dart';
part 'list_functionality_state.dart';
part 'list_functionality_event.dart';

class ListFunctionalityBloc
    extends Bloc<ListFunctionalityEvent, ListFunctionalityState> {
  ListFunctionalityBloc() : super(const ListFunctionalityState());

  @override
  Stream<Transition<ListFunctionalityEvent, ListFunctionalityState>>
      transformEvents(
    Stream<ListFunctionalityEvent> events,
    TransitionFunction<ListFunctionalityEvent, ListFunctionalityState>
        transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<ListFunctionalityState> mapEventToState(
      ListFunctionalityEvent event) async* {
    if (event is DataFetched) {
      yield await _mapListFunctionalityFetchedToState(state);
    }
  }

  // ignore: missing_return
  Future<ListFunctionalityState> _mapListFunctionalityFetchedToState(
      ListFunctionalityState state) async {
    try {
      if (state.status == ListFunctionalityStatus.initial) {
        final listFunctionality = await _fetchListFunction();
        return state.copyWith(
          status: ListFunctionalityStatus.success,
          listFunctionality: listFunctionality,
        );
      }
      // state.copyWith(status: ListFunctionalityStatus.failure);
    } on Exception {
      return state.copyWith(status: ListFunctionalityStatus.failure);
    }
  }

  // Future<Map<String, String>> getToken() async {
  //   await Hive.openBox('Box');
  //   var box = Hive.box('Box');
  //   String token = box.get('token');
  //   // box.close();
  //   var data = {'token': token};
  //   return data;
  // }

  Future<List<Functionality>> _fetchListFunction() async {
    print("getFunctionality");
    var data = await UserRepository().getToken();
    final response = await CallApi().postData(data, "getFunctionality");
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      // if (body[0] as String == 'token_expired') throw Exception('token_valid');
      return body.map((dynamic json) {
        return Functionality(
          id: json['func_id'].toString(),
          name: json['func_name'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching list function');
  }
}
