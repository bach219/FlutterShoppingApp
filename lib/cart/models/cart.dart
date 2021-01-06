import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttercommerce/models/models.dart';

@immutable
class Cart extends Equatable {
  const Cart({this.items = const <Product>[]});

  final List<Product> items;

  double get totalPrice =>
      items.fold(0, (total, current) => total + current.price * (1 - current.sale / 100));

  @override
  List<Object> get props => [items];
}
