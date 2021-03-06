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
part 'best_expensive_phone_event.dart';
part 'best_expensive_phone_state.dart';

class BestExpensivePhoneBloc
    extends Bloc<BestExpensivePhoneEvent, BestExpensivePhoneState> {
  BestExpensivePhoneBloc() : super(const BestExpensivePhoneState());

  @override
  Stream<Transition<BestExpensivePhoneEvent, BestExpensivePhoneState>>
      transformEvents(
    Stream<BestExpensivePhoneEvent> events,
    TransitionFunction<BestExpensivePhoneEvent, BestExpensivePhoneState>
        transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<BestExpensivePhoneState> mapEventToState(
      BestExpensivePhoneEvent event) async* {
    if (event is DataFetched) {
      yield await _mapBestExpensivePhoneFetchedToState(state);
    }
  }

  // ignore: missing_return
  Future<BestExpensivePhoneState> _mapBestExpensivePhoneFetchedToState(
      BestExpensivePhoneState state) async {
    try {
      if (state.status == BestExpensivePhoneStatus.initial) {
        final bestExpensive = await _fetchBestExpensiveProduct();
        return state.copyWith(
          status: BestExpensivePhoneStatus.success,
          bestExpensive: bestExpensive,
        );
      }
      // state.copyWith(status: BestExpensivePhoneStatus.failure);
    } on Exception {
      return state.copyWith(status: BestExpensivePhoneStatus.failure);
    }
  }

  Future<Product> _fetchBestExpensiveProduct() async {
    // print("bestExpensiveProduct");
    var data = await UserRepository().getToken();
    // print("token:     $data");
    final response = await CallApi().postData(data, "bestExpensiveProduct");
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
    throw Exception('error fetching bestExpensiveProduct');
  }
}
