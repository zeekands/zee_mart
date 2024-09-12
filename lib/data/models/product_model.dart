class ProductModel {
  final int categoryId;
  final String categoryName;
  final String sku;
  final String name;
  final String description;
  final int weight;
  final int width;
  final int length;
  final int height;
  final String image;
  final int harga;
  final String id;
  final int categoryID;

  ProductModel({
    this.categoryId = 0,
    this.categoryName = '',
    this.sku = '',
    this.name = '',
    this.description = '',
    this.weight = 0,
    this.width = 0,
    this.length = 0,
    this.height = 0,
    this.image = '',
    this.harga = 0,
    this.id = '',
    this.categoryID = 0,
  });

  // Parsing JSON data to ProductModel
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      categoryId: json['categoryId'] ?? 0,
      categoryName: json['categoryName'] ?? '',
      sku: json['sku'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      weight: json['weight'] ?? 0,
      width: json['width'] ?? 0,
      length: json['length'] ?? 0,
      height: json['height'] ?? 0,
      image: json['image'] ?? '',
      harga: json['harga'] ?? 0,
      id: json['id'] ?? '',
      categoryID: json['CategoryId'] ?? 0,
    );
  }

  // Convert ProductModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'sku': sku,
      'name': name,
      'description': description,
      'weight': weight,
      'width': width,
      'length': length,
      'height': height,
      'image': image,
      'harga': harga,
      'id': id,
      'CategoryId': categoryID,
    };
  }
}
