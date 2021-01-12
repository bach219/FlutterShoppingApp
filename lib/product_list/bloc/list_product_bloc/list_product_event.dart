part of 'list_product_bloc.dart';

abstract class ListProductEvent extends Equatable {
  const ListProductEvent();
}

class ListProductStarted extends ListProductEvent {
  @override
  List<Object> get props => [];
}

class ListProductChosen extends ListProductEvent {
  const ListProductChosen(this.item);

  final Filter item;
  @override
  List<Object> get props => [item];
}
