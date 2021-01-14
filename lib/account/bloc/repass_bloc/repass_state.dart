part of 'repass_bloc.dart';

class RepassState extends Equatable {
  const RepassState({
    this.status = FormzStatus.pure,
    this.nowPassword = const Password.pure(),
    this.newPassword = const Password.pure(),
    this.passwordVerify = const ConfirmedPassword.pure(),
  });

  final FormzStatus status;
  final Password nowPassword;
  final Password newPassword;
  final ConfirmedPassword passwordVerify;

  RepassState copyWith({
    FormzStatus status,
    Password nowPassword,
    Password newPassword,
    ConfirmedPassword passwordVerify,
  }) {
    return RepassState(
      status: status ?? this.status,
      nowPassword: nowPassword ?? this.nowPassword,
      newPassword: newPassword ?? this.newPassword,
      passwordVerify: passwordVerify ?? this.passwordVerify,
    );
  }

  @override
  List<Object> get props => [status, passwordVerify, nowPassword, newPassword];
}
