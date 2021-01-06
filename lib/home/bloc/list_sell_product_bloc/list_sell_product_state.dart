part of 'list_sell_product_bloc.dart';

enum ListProductStatus { initial, failure, success }

class ListProductState extends Equatable {
  const ListProductState({
    this.status = ListProductStatus.initial,
    this.listSell = const <Product>[],
  });

  final ListProductStatus status;
  final List<Product> listSell;

  ListProductState copyWith({
    ListProductStatus status,
    List<Product> listSell,
  }) {
    return ListProductState(
      status: status ?? this.status,
      listSell: listSell ?? this.listSell,
    );
  }

  @override
  List<Object> get props => [
        status,
        listSell,
      ];
}
