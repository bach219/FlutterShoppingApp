part of 'home_bloc.dart';

enum HomeStatus { initial, failure }

class HomeState extends Equatable {
  const HomeState({this.status = HomeStatus.initial, this.client = User.empty});

  final HomeStatus status;
  final User client;

  HomeState copyWith({
    HomeStatus status,
    User client,
  }) {
    return HomeState(
      status: status ?? this.status,
      client: client ?? this.client,
    );
  }

  @override
  List<Object> get props => [status, client];
}
