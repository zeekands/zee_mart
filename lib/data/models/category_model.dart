class CategoryModel {
  final String createdAt;
  final String category;
  final int id;

  CategoryModel({
    required this.createdAt,
    required this.category,
    required this.id,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      createdAt: json['createdAt'] ?? '',
      category: json['categoryName'] ?? 'Unknown Category',
      id: int.tryParse(json['id'] ?? '0') ?? 0, // Convert String to int
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'category': category,
      'id': id,
    };
  }
}
