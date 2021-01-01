part of 'list_functionality_bloc.dart';

enum ListFunctionalityStatus { initial, failure }

class ListFunctionalityState extends Equatable {
  const ListFunctionalityState({
    this.status = ListFunctionalityStatus.initial,
    this.listFunctionality = const <Functionality>[],
  });

  final ListFunctionalityStatus status;
  final List<Functionality> listFunctionality;

  ListFunctionalityState copyWith({
    ListFunctionalityStatus status,
    List<Functionality> listFunctionality,
  }) {
    return ListFunctionalityState(
      status: status ?? this.status,
      listFunctionality: listFunctionality ?? this.listFunctionality,
    );
  }

  @override
  List<Object> get props => [
        status,
        listFunctionality,
      ];
}
