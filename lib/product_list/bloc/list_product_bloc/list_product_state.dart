part of 'list_product_bloc.dart';

// enum ListProductStatus { initial, failure, success }
// part of 'list_product_bloc.dart';

// enum ListProductStatus { initial, failure, success }

// class ListProductState extends Equatable {
//   const ListProductState({
//     this.status = ListProductStatus.initial,
//     this.listNew = const <Product>[],
//   });

//   final ListProductStatus status;
//   final List<Product> listNew;

//   ListProductState copyWith({
//     ListProductStatus status,
//     List<Product> listNew,
//   }) {
//     return ListProductState(
//       status: status ?? this.status,
//       listNew: listNew ?? this.listNew,
//     );
//   }

//   @override
//   List<Object> get props => [
//         status,
//         listNew,
//       ];
// }

abstract class ListProductState extends Equatable {
  const ListProductState();
}

class ListProductLoading extends ListProductState {
  @override
  List<Object> get props => [];
}



class ListProductLoaded extends ListProductState {
  const ListProductLoaded({
    this.listProduct = const <Product>[],
    this.listCategory = const <Category>[],
    this.listFunctionality = const <Functionality>[],
    this.price = const <double>[],
    this.sort = Sort.newProduct
  });

  final List<Product> listProduct;
  final List<Category> listCategory;
  final List<Functionality> listFunctionality;
  final List<double> price;
  final Sort sort;
  @override
  List<Object> get props =>
      [listProduct, listCategory, listFunctionality, price, sort];
}

class ListProductError extends ListProductState {
  @override
  List<Object> get props => [];
}
