import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttercommerce/models/models.dart';
import 'package:fluttercommerce/network/api.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:core';
import 'package:fluttercommerce/Repository/UserRepository/user_repository.dart';
part 'best_sell_phone_event.dart';
part 'best_sell_phone_state.dart';

class BestSellPhoneBloc extends Bloc<BestSellPhoneEvent, BestSellPhoneState> {
  BestSellPhoneBloc() : super(const BestSellPhoneState());

  @override
  Stream<Transition<BestSellPhoneEvent, BestSellPhoneState>> transformEvents(
    Stream<BestSellPhoneEvent> events,
    TransitionFunction<BestSellPhoneEvent, BestSellPhoneState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<BestSellPhoneState> mapEventToState(BestSellPhoneEvent event) async* {
    if (event is DataFetched) {
      yield await _mapBestSellPhoneFetchedToState(state);
    }
  }

  // ignore: missing_return
  Future<BestSellPhoneState> _mapBestSellPhoneFetchedToState(
      BestSellPhoneState state) async {
    try {
      if (state.status == BestSellPhoneStatus.initial) {
        final bestSell = await _fetchBestSellProduct();
        return state.copyWith(
          status: BestSellPhoneStatus.success,
          bestSell: bestSell,
        );
      }
      // state.copyWith(status: BestSellPhoneStatus.failure);
    } on Exception {
      return state.copyWith(status: BestSellPhoneStatus.failure);
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

  Future<Product> _fetchBestSellProduct() async {
    print("bestSellProduct");
    var data = await UserRepository().getToken();
    // print("token:     $data");
    final response = await CallApi().postData(data, "bestSellProduct");
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      // print(body.toString() + "ahihihihihihihihihihi");
      Product product = Product.empty;
      // body.map((dynamic json) {
      product = Product(
        id: body[0]['prod_id'].toString(),
        company: body[0]['cate_name'] as String,
        name: body[0]['prod_name'] as String,
        icon: body[0]['prod_img'] as String,
        rating: 5.0,
        price: double.parse(body[0]['prod_price'].toString()),
        remainingQuantity: body[0]['prod_qty'] as int,
        description: body[0]['prod_name'] as String,
        sale: double.parse(body[0]['prod_sale'].toString()),
      );
      // });
      // print(product.toString() +
      //     "ahiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
      return product;
    }
    throw Exception('error fetching bestSellProduct');
  }
}
