class Dish {
  final String name;
  final String description;
  final String province;
  final String imageUrl;
  final String simplifiedChinese;
  final String notes;

  const Dish({
    required this.name,
    this.description = '',
    this.province = 'Unknown',
    this.imageUrl = '',
    this.simplifiedChinese = 'N/A',
    this.notes = 'N/A',
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      name: json['name'] ?? 'Unknown Dish',
      description: json['description'] ?? 'N/A',
      province: json['province'] ?? 'Unknown',
      imageUrl: json['imageUrl'] ?? '',
      simplifiedChinese: json['simplifiedChinese'] ?? 'N/A',
      notes: json['notes'] ?? 'N/A',
    );
  }
}