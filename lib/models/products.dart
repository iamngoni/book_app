class Product {
  String name;
  String image;
  String category;
  String price;
  String weight;
  String state;
  Product({
    this.name,
    this.image,
    this.category,
    this.price,
    this.weight = '0',
    this.state = 'Live',
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return new Product(
      name: json["name"],
      category: json["category"],
      image: json["image"],
      price: json["price"],
      state: json["state"],
      weight: json["weight"],
    );
  }
}
