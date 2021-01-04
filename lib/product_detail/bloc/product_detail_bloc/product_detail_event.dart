part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DataFetched extends ProductDetailEvent {}
