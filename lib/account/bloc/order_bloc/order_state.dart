// part of 'order_bloc.dart';

// class SignUpState extends Equatable {
//   const SignUpState({
//     this.status = FormzStatus.pure,
//     this.email = const Email.pure(),
//     this.password = const Password.pure(),
//     this.passwordVerify = const ConfirmedPassword.pure(),
//     this.name = const Name.pure(),
//     this.address = const Address.pure(),
//     this.phone = const Phone.pure(),
//     this.sex = const Sex.pure(),
//   });

//   final FormzStatus status;
//   final Email email;
//   final Password password;
//   final ConfirmedPassword passwordVerify;
//   final Name name;
//   final Address address;
//   final Phone phone;
//   final Sex sex;

//   SignUpState copyWith(
//       {FormzStatus status,
//       Email email,
//       Password password,
//       ConfirmedPassword passwordVerify,
//       Name name,
//       Address address,
//       Phone phone,
//       Sex sex}) {
//     return SignUpState(
//         status: status ?? this.status,
//         email: email ?? this.email,
//         password: password ?? this.password,
//         passwordVerify: passwordVerify ?? this.passwordVerify,
//         name: name ?? this.name,
//         phone: phone ?? this.phone,
//         sex: sex ?? this.sex,
//         address: address ?? this.address);
//   }

//   @override
//   List<Object> get props =>
//       [status, email, password, name, passwordVerify, address, phone, sex];
// }
