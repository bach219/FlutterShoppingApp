part of 'home_bloc.dart';

enum HomeStatus { initial, failure }

class HomeState extends Equatable {
  const HomeState(
      {this.status = HomeStatus.initial,
      this.listNew = const <Product>[],
      this.listSell = const <Product>[],
      this.listFunctionality = const <Functionality>[],
      this.bestExpensiveProduct,
      this.bestSellProduct});

  final HomeStatus status;
  final List<Product> listNew;
  final List<Product> listSell;
  final List<Functionality> listFunctionality;
  final Product bestSellProduct;
  final Product bestExpensiveProduct;

  HomeState copyWith(
      {HomeStatus status,
      List<Product> listNew,
      List<Product> listSell,
      List<Functionality> listFunctionality,
      Product bestSellProduct,
      Product bestExpensiveProduct
      // bool hasReachedMax,
      }) {
    return HomeState(
      status: status ?? this.status,
      listNew: listNew ?? this.listNew,
      listSell: listSell ?? this.listSell,
      listFunctionality: listFunctionality ?? this.listFunctionality,
      bestSellProduct: bestSellProduct ?? this.bestSellProduct,
      bestExpensiveProduct: bestExpensiveProduct ?? this.bestExpensiveProduct,
    );
  }

  @override
  List<Object> get props => [
        status,
        listNew,
        listSell,
        listFunctionality,
        bestSellProduct,
        bestExpensiveProduct
      ];
}
