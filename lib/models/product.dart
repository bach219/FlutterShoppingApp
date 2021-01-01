import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Product extends Equatable {
  final double sale;
  final String id;
  final String company;
  final String name;
  final String icon;
  final double rating;
  final double price;
  final int remainingQuantity;
  final String description;

  const Product({
    this.company,
    this.name,
    this.icon,
    this.rating,
    this.price,
    this.remainingQuantity,
    this.description,
    this.id,
    this.sale,
  });

  static const empty = Product(
    sale: 0.0,
    id: '',
    company: '',
    name: '',
    icon: '',
    rating: 0.0,
    price: 0.0,
    remainingQuantity: 0,
    description: '',
  );
  @override
  List<Object> get props => [
        company,
        id,
        name,
        icon,
        rating,
        remainingQuantity,
        description,
        sale,
        price
      ];
  @override
  String toString() {
    return "Product: $company - $id - $name";
  }
}
