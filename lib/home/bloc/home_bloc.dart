import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttercommerce/models/models.dart';
import 'package:fluttercommerce/network/api.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState());

  @override
  Stream<Transition<HomeEvent, HomeState>> transformEvents(
    Stream<HomeEvent> events,
    TransitionFunction<HomeEvent, HomeState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is DataFetched) {
      yield await _mapHomeFetchedToState(state);
    }
  }

  // ignore: missing_return
  Future<HomeState> _mapHomeFetchedToState(HomeState state) async {
    try {
      if (state.status == HomeStatus.initial) {
        final listNew = await _fetchListNew();
        final listSell = await _fetchListSell();
        final listFunctionality = await _fetchListFunction();
        final bestSellProduct = await _fetchBestSellProduct();
        final bestExpensiveProduct = await _fetchBestExpensiveProduct();
        return state.copyWith(
          status: HomeStatus.initial,
          listNew: listNew,
          listSell: listSell,
          listFunctionality: listFunctionality,
          bestExpensiveProduct: bestExpensiveProduct,
          bestSellProduct: bestSellProduct,
        );
      }
      // state.copyWith(status: HomeStatus.failure);
    } on Exception {
      return state.copyWith(status: HomeStatus.failure);
    }
  }

  getToken() async {
    await Hive.openBox('Box');
    var box = Hive.box('Box');
    String token = box.get('token');
    box.close();
    print(token);
    var data = {'token': token};
    return data;
  }

  Future<List<Product>> _fetchListNew() async {
    final response = await CallApi().postData(getToken(), "listProductNew");
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return Product(
          id: json['prod_id'] as String,
          company: json['cate_name'] as String,
          name: json['prod_name'] as String,
          icon: json['prod_img'] as String,
          rating: 5.0,
          price: json['prod_name'] as String,
          remainingQuantity: json['prod_qty'] as int,
          description: json['prod_name'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching List New Product');
  }

  Future<List<Product>> _fetchListSell() async {
    final response =
        await CallApi().postData(getToken(), "listProductBestSelling");
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return Product(
          id: json['prod_id'] as String,
          company: json['cate_name'] as String,
          name: json['prod_name'] as String,
          icon: json['prod_img'] as String,
          rating: 5.0,
          price: json['prod_name'] as String,
          remainingQuantity: json['prod_qty'] as int,
          description: json['prod_name'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching list Sell');
  }

  Future<List<Functionality>> _fetchListFunction() async {
    final response = await CallApi().postData(getToken(), "getFunctionality");
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return Functionality(
          id: json['func_id'] as String,
          name: json['func_name'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching list function');
  }

  Future<Product> _fetchBestSellProduct() async {
    final response = await CallApi().postData(getToken(), "bestSellProduct");
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      body.map((dynamic json) {
        return Product(
          id: json['prod_id'] as String,
          company: json['cate_name'] as String,
          name: json['prod_name'] as String,
          icon: json['prod_img'] as String,
          rating: 5.0,
          price: json['prod_name'] as String,
          remainingQuantity: json['prod_qty'] as int,
          description: json['prod_name'] as String,
        );
      });
    }
    throw Exception('error fetching bestSellProduct');
  }

  Future<Product> _fetchBestExpensiveProduct() async {
    final response =
        await CallApi().postData(getToken(), "bestExpensiveProduct");
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      body.map((dynamic json) {
        return Product(
          id: json['prod_id'] as String,
          company: json['cate_name'] as String,
          name: json['prod_name'] as String,
          icon: json['prod_img'] as String,
          rating: 5.0,
          price: json['prod_name'] as String,
          remainingQuantity: json['prod_qty'] as int,
          description: json['prod_name'] as String,
        );
      });
    }
    throw Exception('error fetching bestExpensiveProduct');
  }
}
