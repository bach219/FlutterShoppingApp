import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// {@template user}
/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({
    @required this.email,
    @required this.id,
    @required this.name,
    @required this.sex,
    @required this.phone,
    @required this.address,
    this.photo,
  })  : assert(email != null),
        assert(id != null);

  /// The current user's email address.
  final String email;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String name;

  /// Url for the current user's photo.
  final String photo;

  final String phone;

  final String address;

  final String sex;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(
      email: '',
      id: '',
      name: null,
      photo: null,
      phone: null,
      address: null,
      sex: null);

  @override
  List<Object> get props => [email, id, name, photo, phone, address, sex];

  @override
  String toString() {
    return "User: $email + $address + $phone";
  }
}
