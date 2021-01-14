part of 'info_bloc.dart';

abstract class InfoEvent extends Equatable {
  const InfoEvent();

  @override
  List<Object> get props => [];
}

class InfoStarted extends InfoEvent {
  final User client;

  InfoStarted({this.client});
  @override
  List<Object> get props => [client];
}

class InfoEmailChanged extends InfoEvent {
  const InfoEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class InfoAddressChanged extends InfoEvent {
  const InfoAddressChanged(this.address);

  final String address;

  @override
  List<Object> get props => [address];
}

class InfoPhoneChanged extends InfoEvent {
  const InfoPhoneChanged(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

class InfoSexChanged extends InfoEvent {
  const InfoSexChanged(this.sex);

  final String sex;

  @override
  List<Object> get props => [sex];
}

class InfoNameChanged extends InfoEvent {
  const InfoNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class InfoSubmitted extends InfoEvent {
  const InfoSubmitted();
}
