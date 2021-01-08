import 'package:equatable/equatable.dart';
import 'package:fluttercommerce/models/models.dart';
import 'package:hive/hive.dart';
// part 'item.g.dart';

// @HiveType(typeId: 30)
class Item extends Equatable {
  // final Product product;
  // @HiveField(0)
  final double sale;
  // @HiveField(1)
  final String id;
  // @HiveField(2)
  final String company;
  // @HiveField(3)
  final String name;
  // @HiveField(4)
  final String icon;
  // @HiveField(5)
  final double rating;
  // @HiveField(6)
  final double price;
  // @HiveField(7)
  final int remainingQuantity;
  // @HiveField(8)
  final int qty;

  Item(
      {this.sale,
      this.id,
      this.company,
      this.name,
      this.icon,
      this.rating,
      this.price,
      this.remainingQuantity,
      this.qty});

  Map toJson() => {
        'sale': sale,
        'id': id,
        'company': company,
        'name': name,
        'icon': icon,
        'rating': rating,
        'price': price,
        'remainingQuantity': remainingQuantity,
        'qty': qty,
      };

  @override
  List<Object> get props => [
        sale,
        id,
        company,
        name,
        icon,
        rating,
        price,
        remainingQuantity,
        qty,
      ];
  @override
  String toString() {
    return "Item: qty: $qty - id: $id";
  }
}
