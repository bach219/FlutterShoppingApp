import 'dart:async';
import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttercommerce/models/models.dart';
import 'package:rxdart/rxdart.dart';
import 'package:hive/hive.dart';
import 'package:fluttercommerce/Repository/repository.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(const ProductDetailState());

  @override
  Stream<Transition<ProductDetailEvent, ProductDetailState>> transformEvents(
    Stream<ProductDetailEvent> events,
    TransitionFunction<ProductDetailEvent, ProductDetailState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<ProductDetailState> mapEventToState(ProductDetailEvent event) async* {
    if (event is DataFetched) {
      // print(event.id.toString() + "mapEventToState");
      yield await _mapProductDetailFetchedToState(state);
    }
  }

  // ignore: missing_return
  Future<ProductDetailState> _mapProductDetailFetchedToState(
      ProductDetailState state) async {
    try {
      if (state.status == ProductDetailStatus.initial) {
        await Hive.openBox('Box');
        var box = Hive.box('Box');
        String id = box.get('idDetail');
        String company = box.get('companyDetail');

        final listImage = await DetailRepository().fetchListImage(id);
        final listComment = await DetailRepository().fetchListComment(id);
        final listMore = await DetailRepository().fetchListMore(company);
        final product = await DetailRepository().fetchDetailProduct(id);
        return state.copyWith(
          status: ProductDetailStatus.success,
          listImages: listImage,
          listComment: listComment,
          listMore: listMore,
          product: product,
        );
      }
      // state.copyWith(status: ProductDetailStatus.failure);
    } on Exception {
      return state.copyWith(status: ProductDetailStatus.failure);
    }
  }

}
