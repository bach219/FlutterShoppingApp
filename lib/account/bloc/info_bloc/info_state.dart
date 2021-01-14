part of 'info_bloc.dart';

class InfoState extends Equatable {
  const InfoState({
    this.status = FormzStatus.pure,
    this.email = const Email.pure(),
    this.name = const Name.pure(),
    this.address = const Address.pure(),
    this.phone = const Phone.pure(),
    this.sex = const Sex.pure(),
    this.client = User.empty,
  });

  final FormzStatus status;
  final Email email;
  final Name name;
  final Address address;
  final Phone phone;
  final Sex sex;
  final User client;

  
  InfoState copyWith(
      {FormzStatus status,
      Email email,
      Name name,
      Address address,
      Phone phone,
      Sex sex,
      User client}) {
    return InfoState(
      status: status ?? this.status,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      sex: sex ?? this.sex,
      address: address ?? this.address,
      client: client ?? this.client,
    );
  }

  @override
  List<Object> get props => [
        status,
        email,
        name,
        address,
        phone,
        sex,
        client,
      ];
}
