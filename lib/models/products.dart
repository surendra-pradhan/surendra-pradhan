class Product {
  final String id;
  final String title;
  final String image;
  final double price;
  final String description;
  final String category;
  final String subcategory;
  final double ratting;
  final bool isfavorite;
  final Map<String, bool> size;
  final List comments;

  Product(
      {this.id,
      this.title,
      this.category,
      this.image,
      this.price,
      this.description,
      this.ratting,
      this.subcategory,
      this.size,
      this.isfavorite,
      this.comments});
}
