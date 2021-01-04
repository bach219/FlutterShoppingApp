import 'package:equatable/equatable.dart';

class Images extends Equatable {
  final String id;
  final String image;

  Images({this.image, this.id});

  List<Object> get props => [];
  @override
  String toString() {
    return "Images: $id - $image";
  }
}
