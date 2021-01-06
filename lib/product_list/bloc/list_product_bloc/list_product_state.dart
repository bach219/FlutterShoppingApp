part of 'list_product_bloc.dart';

enum ListProductStatus { initial, failure, success }

class ListProductState extends Equatable {
  const ListProductState({
    this.status = ListProductStatus.initial,
    this.listNew = const <Product>[],
  });

  final ListProductStatus status;
  final List<Product> listNew;

  ListProductState copyWith({
    ListProductStatus status,
    List<Product> listNew,
  }) {
    return ListProductState(
      status: status ?? this.status,
      listNew: listNew ?? this.listNew,
    );
  }

  @override
  List<Object> get props => [
        status,
        listNew,
      ];
}
