part of 'best_sell_phone_bloc.dart';

enum BestSellPhoneStatus { initial, failure }

class BestSellPhoneState extends Equatable {
  const BestSellPhoneState({
    this.status = BestSellPhoneStatus.initial,
    this.bestSell = Product.empty,
  });

  final BestSellPhoneStatus status;
  final Product bestSell;

  BestSellPhoneState copyWith({
    BestSellPhoneStatus status,
    Product bestSell,
  }) {
    return BestSellPhoneState(
      status: status ?? this.status,
      bestSell: bestSell ?? this.bestSell,
    );
  }

  @override
  List<Object> get props => [
        status,
        bestSell,
      ];
}
