part of 'product_detail_bloc.dart';

enum ProductDetailStatus { initial, failure, success }

class ProductDetailState extends Equatable {
  const ProductDetailState({
    this.status = ProductDetailStatus.initial,
    this.listImages = const <Images>[],
    this.product = Product.empty,
    this.listComment = const <Comment>[],
    this.listMore = const <Product>[],
  });

  final ProductDetailStatus status;
  final List<Images> listImages;
  final Product product;
  final List<Comment> listComment;
  final List<Product> listMore;

  ProductDetailState copyWith(
      {ProductDetailStatus status,
      List<Images> listImages,
      Product product,
      List<Comment> listComment,
      List<Product> listMore}) {
    return ProductDetailState(
        status: status ?? this.status,
        listImages: listImages ?? this.listImages,
        product: product ?? product,
        listComment: listComment ?? listComment,
        listMore: listMore ?? listMore);
  }

  @override
  List<Object> get props =>
      [status, listImages, listMore, product, listComment];
}
