import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttercommerce/models/models.dart' as models;

enum Sort { newProduct, priceHighToLow, priceLowToHigh }

@immutable
class Filter extends Equatable {
  const Filter({
    this.listCategory = const <models.Category>[],
    this.listFunctionality = const <models.Functionality>[],
    this.price = const <double>[],
    this.sort = Sort.newProduct
  });

  final List<models.Category> listCategory;
  final List<models.Functionality> listFunctionality;
  final List<double> price;
  final Sort sort;

  // double get totalPrice => items.fold(
  //     0,
  //     (total, current) =>
  //         total + current.price * (1 - current.sale / 100) * current.qty);

  @override
  List<Object> get props => [listCategory, listFunctionality, price, sort];
}
