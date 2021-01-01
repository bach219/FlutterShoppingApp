part of 'list_functionality_bloc.dart';

abstract class ListFunctionalityEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DataFetched extends ListFunctionalityEvent {}
