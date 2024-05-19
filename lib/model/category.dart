class CategoryModel {
  final String? id;
  final String? name;
  final String? image;
  final String? type;

  CategoryModel({
    this.id,
    this.name,
    this.image,
    this.type,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      type: json['type'],
    );
  }
}
