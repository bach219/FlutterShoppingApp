import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import './item.dart';

@immutable
class Cart extends Equatable {
  const Cart({this.items = const <Item>[]});

  final List<Item> items;

  double get totalPrice => items.fold(
      0,
      (total, current) =>
          total + current.price * (1 - current.sale / 100) * current.qty);

  @override
  List<Object> get props => [items];
}
