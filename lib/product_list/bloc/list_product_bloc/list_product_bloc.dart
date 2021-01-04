import 'dart:async';
import 'dart:convert';
import 'package:fluttercommerce/Repository/UserRepository/user_repository.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttercommerce/models/models.dart';
import 'package:fluttercommerce/network/api.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:core';
part 'list_product_event.dart';
part 'list_product_state.dart';

class ListProductBloc extends Bloc<ListProductEvent, ListProductState> {
  ListProductBloc() : super(const ListProductState());

  @override
  Stream<Transition<ListProductEvent, ListProductState>> transformEvents(
    Stream<ListProductEvent> events,
    TransitionFunction<ListProductEvent, ListProductState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<ListProductState> mapEventToState(ListProductEvent event) async* {
    if (event is DataFetched) {
      yield await _mapListProductFetchedToState(state);
    }
  }

  // ignore: missing_return
  Future<ListProductState> _mapListProductFetchedToState(
      ListProductState state) async {
    try {
      if (state.status == ListProductStatus.initial) {
        final listNew = await _fetchListNew();
        return state.copyWith(
          status: ListProductStatus.initial,
          listNew: listNew,
        );
      }
      // state.copyWith(status: ListProductStatus.failure);
    } on Exception {
      return state.copyWith(status: ListProductStatus.failure);
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

  Future<List<Product>> _fetchListNew() async {
    print("productList");
    var data = await UserRepository().getToken();
    final response = await CallApi().postData(data, "productList");
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return Product(
          id: json['prod_id'].toString(),
          company: json['cate_name'] as String,
          name: json['prod_name'] as String,
          icon: json['prod_img'] as String,
          rating: 5.0,
          price: double.parse(json['prod_price'].toString()),
          remainingQuantity: json['prod_qty'] as int,
          description: json['prod_name'] as String,
          sale: double.parse(json['prod_sale'].toString()),
        );
      }).toList();
    }
    throw Exception('error fetching List Product');
  }
}
