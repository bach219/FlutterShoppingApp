part of 'signup_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

// class SignUpUsernameChanged extends SignUpEvent {
//   const SignUpUsernameChanged(this.username);

//   final String username;

//   @override
//   List<Object> get props => [username];
// }

class SignUpPasswordChanged extends SignUpEvent {
  const SignUpPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class SignUpEmailChanged extends SignUpEvent {
  const SignUpEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class SignUpPasswordVerifyChanged extends SignUpEvent {
  const SignUpPasswordVerifyChanged(this.passwordVerify);

  final String passwordVerify;

  @override
  List<Object> get props => [passwordVerify];
}

class SignUpAddressChanged extends SignUpEvent {
  const SignUpAddressChanged(this.address);

  final String address;

  @override
  List<Object> get props => [address];
}

class SignUpPhoneChanged extends SignUpEvent {
  const SignUpPhoneChanged(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

class SignUpSexChanged extends SignUpEvent {
  const SignUpSexChanged(this.sex);

  final String sex;

  @override
  List<Object> get props => [sex];
}

class SignUpNameChanged extends SignUpEvent {
  const SignUpNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class SignUpSubmitted extends SignUpEvent {
  const SignUpSubmitted();
}
