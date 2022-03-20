class Product {
  int? id;
  String? name;
  String? brand;
  String? imagePath;
  num? price;
  String? description;

  Product(
      {this.id,
      this.name,
      this.brand,
      this.imagePath,
      this.price,
      this.description});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      brand: json['brand'],
      imagePath: json['image_path'],
      price: json['price'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['name'] = name;
    json['brand'] = brand;
    json['image_path'] = imagePath;
    json['price'] = price;
    json['description'] = description;
    return json;
  }
}
