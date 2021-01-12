part of 'checkout_bloc.dart';

abstract class CheckOutEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DataFetched extends CheckOutEvent {}

