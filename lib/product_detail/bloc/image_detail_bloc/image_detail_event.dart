part of 'image_detail_bloc.dart';

abstract class ImageDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DataFetched extends ImageDetailEvent {}
