part of 'best_expensive_phone_bloc.dart';

enum BestExpensivePhoneStatus { initial, failure }

class BestExpensivePhoneState extends Equatable {
  const BestExpensivePhoneState({
    this.status = BestExpensivePhoneStatus.initial,
    this.bestExpensive = Product.empty,
  });

  final BestExpensivePhoneStatus status;
  final Product bestExpensive;

  BestExpensivePhoneState copyWith({
    BestExpensivePhoneStatus status,
    Product bestExpensive,
  }) {
    return BestExpensivePhoneState(
      status: status ?? this.status,
      bestExpensive: bestExpensive ?? this.bestExpensive,
    );
  }

  @override
  List<Object> get props => [
        status,
        bestExpensive,
      ];
}
