import 'dart:async';
import 'dart:convert';
import 'package:fluttercommerce/Repository/UserRepository/user_repository.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttercommerce/models/models.dart';
import 'package:fluttercommerce/network/api.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:core';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState());

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
    Stream<SearchEvent> events,
    TransitionFunction<SearchEvent, SearchState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is DataFetched) {
      yield await _mapSearchFetchedToState(state);
    }
  }

  // ignore: missing_return
  Future<SearchState> _mapSearchFetchedToState(SearchState state) async {
    try {
      if (state.status == SearchStatus.initial) {
        final List<String> listImage = [
          'https://images.unsplash.com/photo-1534452203293-494d7ddbf7e0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1352&q=80',
          'https://images.unsplash.com/photo-1513884923967-4b182ef167ab?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
          'https://images.unsplash.com/photo-1513885535751-8b9238bd345a?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
          'https://images.unsplash.com/photo-1483985988355-763728e1935b?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
          'https://images.unsplash.com/photo-1487412912498-0447578fcca8?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
          'https://images.unsplash.com/photo-1526178613552-2b45c6c302f0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
          'https://images.unsplash.com/photo-1472417583565-62e7bdeda490?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
        ];
        return state.copyWith(
          status: SearchStatus.initial,
          listImage: listImage,
        );
      }
      // state.copyWith(status: SearchStatus.failure);
    } on Exception {
      return state.copyWith(status: SearchStatus.failure);
    }
  }

  // Future<dynamic> _fetchlistSearch() async {
  //   print("SearchNew");
  //   var data = await UserRepository().getToken();
  //   final response = await CallApi().postData(data, "SearchNew");
  //   if (response.statusCode == 200) {
  //     final body = json.decode(response.body) as List;
  //     if (body.length > 1)
  //       return body.map((dynamic json) {
  //         return Product(
  //           id: json['prod_id'].toString(),
  //           company: json['cate_name'] as String,
  //           name: json['prod_name'] as String,
  //           icon: json['prod_img'] as String,
  //           rating: 5.0,
  //           price: double.parse(json['prod_price'].toString()),
  //           remainingQuantity: json['prod_qty'] as int,
  //           description: json['prod_name'] as String,
  //           sale: double.parse(json['prod_sale'].toString()),
  //         );
  //       }).toList();
  //     return Product(
  //       id: body[0]['prod_id'].toString(),
  //       company: body[0]['cate_name'] as String,
  //       name: body[0]['prod_name'] as String,
  //       icon: body[0]['prod_img'] as String,
  //       rating: 5.0,
  //       price: double.parse(body[0]['prod_price'].toString()),
  //       remainingQuantity: body[0]['prod_qty'] as int,
  //       description: body[0]['prod_name'] as String,
  //       sale: double.parse(body[0]['prod_sale'].toString()),
  //     );
  //   }
  //   throw Exception('error fetching List search');
  // }
}