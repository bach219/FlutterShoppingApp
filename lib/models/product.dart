class Product {
  final String id;
  final String company;
  final String name;
  final String icon;
  final double rating;
  final String price;
  final int remainingQuantity;
  final String description;

  Product(
      {this.company,
      this.name,
      this.icon,
      this.rating,
      this.price,
      this.remainingQuantity,
      this.description,
      this.id});
}
