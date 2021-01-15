part of 'filter_bloc.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();
}

class FilterStarted extends FilterEvent {
  @override
  List<Object> get props => [];
}

class FilterItemAdded extends FilterEvent {
  const FilterItemAdded(this.filter);

  final Filter filter;

  @override
  List<Object> get props => [filter];
}

class FilterItemDeleted extends FilterEvent {
  const FilterItemDeleted(this.filter);

  final Filter filter;

  @override
  List<Object> get props => [filter];
}

