part of 'checkout_bloc.dart';

enum CheckOutStatus { initial, failure }

class CheckOutState extends Equatable {
  const CheckOutState({
    this.status = CheckOutStatus.initial,
    this.client = User.empty,
  });

  final CheckOutStatus status;
  final User client;

  CheckOutState copyWith({CheckOutStatus status, User client}) {
    return CheckOutState(
      status: status ?? this.status,
      client: client ?? this.client,
    );
  }

  @override
  List<Object> get props => [
        status,
        client,
      ];
}