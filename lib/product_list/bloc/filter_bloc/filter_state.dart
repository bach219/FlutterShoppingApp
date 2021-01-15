part of 'filter_bloc.dart';

abstract class FilterState extends Equatable {
  const FilterState();
}

class FilterLoading extends FilterState {
  @override
  List<Object> get props => [];
}

class FilterLoaded extends FilterState {
  const FilterLoaded({
    this.listProduct = const <Product>[],
    this.filter = const Filter(),
  });

  final List<Product> listProduct;
  final Filter filter;

  @override
  List<Object> get props => [listProduct, filter];
}

class FilterError extends FilterState {
  @override
  List<Object> get props => [];
}
