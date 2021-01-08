part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class CartStarted extends CartEvent {
  @override
  List<Object> get props => [];
}

class CartItemAdded extends CartEvent {
  const CartItemAdded(this.item);

  final Item item;

  @override
  List<Object> get props => [item];
}

class CartItemDeleted extends CartEvent {
  const CartItemDeleted(this.item);

  final Item item;

  @override
  List<Object> get props => [item];
}

class CartItemAddUpdated extends CartEvent {
  const CartItemAddUpdated(this.item);

  final Item item;
  @override
  List<Object> get props => [item];
}

class CartItemSubUpdated extends CartEvent {
  const CartItemSubUpdated(this.item);

  final Item item;
  @override
  List<Object> get props => [item];
}
