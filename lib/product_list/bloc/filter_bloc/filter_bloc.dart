import 'dart:async';
import 'package:hive/hive.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:core';
import 'dart:convert';
import 'package:fluttercommerce/Repository/repository.dart';
import 'package:fluttercommerce/models/models.dart';
import 'package:fluttercommerce/product_list/models/filter.dart';
import 'package:pedantic/pedantic.dart';
part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterLoading());

  @override
  Stream<FilterState> mapEventToState(
    FilterEvent event,
  ) async* {
    if (event is FilterStarted) {
      yield* _mapFilterStartedToState();
    } else if (event is FilterItemAdded) {
      yield* _mapFilterItemAddedToState(event, state);
    } else if (event is FilterItemDeleted) {
      yield* _mapFilterItemDeletedToState(event, state);
    } 
  }

  Stream<FilterState> _mapFilterStartedToState() async* {
    yield FilterLoaded();
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      yield const FilterLoaded();
    } catch (_) {
      yield FilterError();
    }
  }

  Stream<FilterState> _mapFilterItemAddedToState(
      FilterItemAdded event, FilterState state) async* {
    if (state is FilterLoaded) {
      try {
        // unawaited(await ItemRepository().addItemToList(event.item));
        // yield FilterLoaded(
        //   cart: Filter(items: await ItemRepository().getListItem()),
        // );
      } on Exception {
        yield FilterError();
      }
    }
  }

  Stream<FilterState> _mapFilterItemDeletedToState(
      FilterItemDeleted event, FilterState state) async* {
    if (state is FilterLoaded) {
      try {
        // unawaited(await ItemRepository().removeItemFromList(event.item));
        // yield FilterLoaded(
        //   cart: Filter(items: await ItemRepository().getListItem()),
        // );
      } on Exception {
        yield FilterError();
      }
    }
  }
}
