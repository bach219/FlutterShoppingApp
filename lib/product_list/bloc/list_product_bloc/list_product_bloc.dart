import 'dart:async';
import 'dart:convert';
import 'package:fluttercommerce/Repository/repository.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttercommerce/product_list/models/filter.dart';
import 'package:fluttercommerce/network/api.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:fluttercommerce/models/models.dart';
import 'dart:core';
part 'list_product_event.dart';
part 'list_product_state.dart';

class ListProductBloc extends Bloc<ListProductEvent, ListProductState> {
  ListProductBloc() : super(ListProductLoading());

  @override
  Stream<ListProductState> mapEventToState(ListProductEvent event) async* {
    if (event is ListProductStarted) {
      yield* _mapListProductStartedToState();
    }
  }

  // ignore: missing_return
  Stream<ListProductState> _mapListProductStartedToState() async* {
    // yield ListProductLoaded();
    try {
      // await Future<void>.delayed(const Duration(seconds: 1));
      yield ListProductLoaded(
        listProduct: await ListRepository().fetchListNew(),
        listCategory: await CategoryRepository().fetchListCategory(),
        listFunctionality: await FunctionalityRepository().fetchListFunction(),
        price: [await ListRepository().fetchBestExpensive(), await ListRepository().fetchCheapest()]
      );
    } catch (_) {
      yield ListProductError();
    }
  }
}
