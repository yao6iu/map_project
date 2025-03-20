class Dish {
  final String name;
  final String description;
  final String province;
  final String imageUrl;

  Dish({
    required this.name,
    required this.description,
    required this.province,
    required this.imageUrl,
  });

  factory Dish.fromApi(Map<String, dynamic> data) {
    return Dish(
      name: data['title'] ?? 'Unknown',
      description: data['description'] ?? 'No description available',
      imageUrl: data['image'] ?? '',
      province: 'Unknown',
    );
  }
}
