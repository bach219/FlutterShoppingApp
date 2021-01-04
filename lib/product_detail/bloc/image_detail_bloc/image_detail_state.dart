part of 'image_detail_bloc.dart';

enum ImageDetailStatus { initial, failure }

class ImageDetailState extends Equatable {
  const ImageDetailState({
    this.status = ImageDetailStatus.initial,
    this.listImages = const <Images>[],
  });

  final ImageDetailStatus status;
  final List<Images> listImages;

  ImageDetailState copyWith(
      {ImageDetailStatus status,
      List<Images> listImages}) {
    return ImageDetailState(
      status: status ?? this.status,
      listImages: listImages ?? this.listImages,
    );
  }

  @override
  List<Object> get props => [status, listImages];
}
