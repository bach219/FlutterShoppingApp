import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

// @HiveType(typeId: 1)
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

  final String ram;

  final String hardDrive;

  final String warranty;

  final String accessories;

  final String promotion;

  // Map toJson() => {
  //       'sale': sale,
  //       'id': id,
  //       'company': company,
  //       'name': '',
  //       'icon': icon,
  //       'rating': rating,
  //       'price': price,
  //       'remainingQuantity': remainingQuantity,
  //       'description': description,
  //       'ram': ram,
  //       'hardDrive': hardDrive,
  //       'accessories': accessories,
  //       'warranty': warranty,
  //       'promotion': promotion
  //     };

  const Product(
      {this.company,
      this.name,
      this.icon,
      this.rating,
      this.price,
      this.remainingQuantity,
      this.description,
      this.id,
      this.sale,
      this.hardDrive,
      this.accessories,
      this.warranty,
      this.ram,
      this.promotion});

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
      ram: '',
      hardDrive: '',
      accessories: '',
      warranty: '',
      promotion: '');
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
        price,
        ram,
        hardDrive,
        accessories,
        warranty,
        promotion
      ];
  @override
  String toString() {
    return "Product: $company - $id - $name";
  }
}
