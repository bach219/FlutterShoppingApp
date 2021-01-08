import 'dart:async';
import 'package:hive/hive.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:core';
import 'dart:convert';
import 'package:fluttercommerce/Repository/repository.dart';
import 'package:fluttercommerce/cart/models/models.dart';
import 'package:pedantic/pedantic.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading());

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is CartStarted) {
      yield* _mapCartStartedToState();
    } else if (event is CartItemAdded) {
      yield* _mapCartItemAddedToState(event, state);
    } else if (event is CartItemDeleted) {
      yield* _mapCartItemDeletedToState(event, state);
    } else if (event is CartItemAddUpdated) {
      yield* _mapCartItemAddUpdatedToState(event, state);
    } else if (event is CartItemSubUpdated) {
      yield* _mapCartItemSubUpdatedToState(event, state);
    }
  }

  Stream<CartState> _mapCartStartedToState() async* {
    yield CartLoaded();
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      yield const CartLoaded();
    } catch (_) {
      yield CartError();
    }
  }

  Stream<CartState> _mapCartItemAddedToState(
      CartItemAdded event, CartState state) async* {
    if (state is CartLoaded) {
      try {
        unawaited(await ItemRepository().addItemToList(event.item));
        yield CartLoaded(
          cart: Cart(items: await ItemRepository().getListItem()),
        );
      } on Exception {
        yield CartError();
      }
    }
  }

  Stream<CartState> _mapCartItemDeletedToState(
      CartItemDeleted event, CartState state) async* {
    if (state is CartLoaded) {
      try {
        unawaited(await ItemRepository().removeItemFromList(event.item));
        yield CartLoaded(
          cart: Cart(items: await ItemRepository().getListItem()),
        );
      } on Exception {
        yield CartError();
      }
    }
  }

  Stream<CartState> _mapCartItemAddUpdatedToState(
      CartItemAddUpdated event, CartState state) async* {
    if (state is CartLoaded) {
      try {
        unawaited(await ItemRepository().updateAddItemToList(event.item));

        // await ItemRepository().updateAddItemToList(event.item);
        yield CartLoaded(
          cart: Cart(items: await ItemRepository().getListItem()),
        );
      } on Exception {
        yield CartError();
      }
    }
  }

  Stream<CartState> _mapCartItemSubUpdatedToState(
      CartItemSubUpdated event, CartState state) async* {
    if (state is CartLoaded) {
      try {
        unawaited(await ItemRepository().updateSubItemToList(event.item));

        // await ItemRepository().updateItemToList(event.item, event.update);
        yield CartLoaded(
          cart: Cart(items: await ItemRepository().getListItem()),
        );
      } on Exception {
        yield CartError();
      }
    }
  }
}
