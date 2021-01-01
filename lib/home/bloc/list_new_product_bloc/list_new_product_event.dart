part of 'list_new_product_bloc.dart';

abstract class ListProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DataFetched extends ListProductEvent {}
