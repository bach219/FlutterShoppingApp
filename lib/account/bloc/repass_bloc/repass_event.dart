part of 'repass_bloc.dart';

abstract class RepassEvent extends Equatable {
  const RepassEvent();

  @override
  List<Object> get props => [];
}

class RepassPasswordNowChanged extends RepassEvent {
  const RepassPasswordNowChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class RepassPasswordNewChanged extends RepassEvent {
  const RepassPasswordNewChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class RepassPasswordVerifyChanged extends RepassEvent {
  const RepassPasswordVerifyChanged(this.passwordVerify);

  final String passwordVerify;

  @override
  List<Object> get props => [passwordVerify];
}

class RepassSubmitted extends RepassEvent {
  const RepassSubmitted();
}
