part of 'search_bloc.dart';

enum SearchStatus { initial,  failure }

class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.initial,
    this.listImage = const <String>[],
  });

  final SearchStatus status;
  final List<String> listImage;
  SearchState copyWith(
      {SearchStatus status, List<String> listImage}) {
    return SearchState(
      status: status ?? this.status,
      listImage: listImage ?? this.listImage,
    );
  }

  @override
  List<Object> get props => [
        status,
        listImage,
      ];
}
