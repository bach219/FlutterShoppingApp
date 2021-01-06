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
        final client = await _fetchClient();
        return state.copyWith(
          status: HomeStatus.success,
          client: client,
        );
      }
      // state.copyWith(status: HomeStatus.failure);
    } on Exception {
      return state.copyWith(status: HomeStatus.failure);
    }
  }

  // Future<Map<String, String>> getToken() async {
  //   await Hive.openBox('Box');
  //   var box = Hive.box('Box');
  //   String token = box.get('token');
  //   // box.close();
  //   // print(token);
  //   var data = {'token': token};
  //   return data;
  // }

  Future<User> _fetchClient() async {
    print("bestSellProduct");
    User getClient = await UserRepository().getUser();
    return getClient;
    // throw Exception('error fetching bestSellProduct');
  }

  // Future<List<Product>> _fetchListNew() async {
  //   print("listProductNew");
  //   var data = await getToken();
  //   final response = await CallApi().postData(data, "listProductNew");
  //   if (response.statusCode == 200) {
  //     final body = json.decode(response.body) as List;
  //     return body.map((dynamic json) {
  //       return Product(
  //         id: json['prod_id'].toString(),
  //         company: json['cate_name'] as String,
  //         name: json['prod_name'] as String,
  //         icon: json['prod_img'] as String,
  //         rating: 5.0,
  //         price: json['prod_price'].toString(),
  //         remainingQuantity: json['prod_qty'] as int,
  //         description: json['prod_name'] as String,
  //       );
  //     }).toList();
  //   }
  //   throw Exception('error fetching List New Product');
  // }

  // Future<List<Product>> _fetchListSell() async {
  //   print("listProductBestSelling");
  //   var data = await getToken();
  //   final response = await CallApi().postData(data, "listProductBestSelling");
  //   if (response.statusCode == 200) {
  //     final body = json.decode(response.body) as List;
  //     return body.map((dynamic json) {
  //       return Product(
  //         id: json['prod_id'].toString(),
  //         company: json['cate_name'] as String,
  //         name: json['prod_name'] as String,
  //         icon: json['prod_img'] as String,
  //         rating: 5.0,
  //         price: json['prod_price'].toString(),
  //         remainingQuantity: json['prod_qty'] as int,
  //         description: json['prod_name'] as String,
  //       );
  //     }).toList();
  //   }
  //   throw Exception('error fetching list Sell');
  // }

  // Future<List<Functionality>> _fetchListFunction() async {
  //   print("getFunctionality");
  //   var data = await getToken();
  //   final response = await CallApi().postData(data, "getFunctionality");
  //   if (response.statusCode == 200) {
  //     final body = json.decode(response.body) as List;
  //     return body.map((dynamic json) {
  //       return Functionality(
  //         id: json['func_id'].toString(),
  //         name: json['func_name'] as String,
  //       );
  //     }).toList();
  //   }
  //   throw Exception('error fetching list function');
  // }

  // Future<Product> _fetchBestSellProduct() async {
  //   print("bestSellProduct");
  //   var data = await getToken();
  //   final response = await CallApi().postData(data, "bestSellProduct");
  //   if (response.statusCode == 200) {
  //     final body = json.decode(response.body) as List;
  //     Product product;
  //     body.map((dynamic json) {
  //       product = Product(
  //         id: json['prod_id'].toString(),
  //         company: json['cate_name'] as String,
  //         name: json['prod_name'] as String,
  //         icon: json['prod_img'] as String,
  //         rating: 5.0,
  //         price: json['prod_price'] as double,
  //         remainingQuantity: json['prod_qty'] as int,
  //         description: json['prod_name'] as String,
  //       );
  //     });
  //     return product;
  //   }
  //   throw Exception('error fetching bestSellProduct');
  // }

  // Future<Product> _fetchBestExpensiveProduct() async {
  //   print("bestExpensiveProduct");
  //   var data = await getToken();
  //   final response = await CallApi().postData(data, "bestExpensiveProduct");
  //   if (response.statusCode == 200) {
  //     final body = json.decode(response.body) as List;
  //     Product product;
  //     body.map((dynamic json) {
  //       product = Product(
  //         id: json['prod_id'].toString(),
  //         company: json['cate_name'] as String,
  //         name: json['prod_name'] as String,
  //         icon: json['prod_img'] as String,
  //         rating: 5.0,
  //         price: json['prod_price'] as double,
  //         remainingQuantity: json['prod_qty'] as int,
  //         description: json['prod_name'] as String,
  //       );
  //     });
  //     return product;
  //   }
  //   throw Exception('error fetching bestExpensiveProduct');
  // }
}
