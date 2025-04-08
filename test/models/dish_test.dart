import 'package:flutter_test/flutter_test.dart';
import 'package:menu_map/models/dish.dart';

void main() {
  group('Dish Class Tests', () {
    test('Dish creation from JSON should populate fields correctly', () {
      final Map<String, dynamic> json = {
        'name': 'Egg Dumplings',
        'description': 'A tasty egg-based dumpling dish.',
        'province': 'Hunan',
        'imageUrl': 'https://example.com/egg_dumplings.jpg',
        'simplifiedChinese': '蛋饺',
        'notes': 'Delicious!'
      };


      final dish = Dish.fromJson(json);


      expect(dish.name, 'Egg Dumplings');
      expect(dish.description, 'A tasty egg-based dumpling dish.');
      expect(dish.province, 'Hunan');
      expect(dish.imageUrl, 'https://example.com/egg_dumplings.jpg');
      expect(dish.simplifiedChinese, '蛋饺');
      expect(dish.notes, 'Delicious!');
    });

    test('Dish creation with missing fields should use default values', () {

      final Map<String, dynamic> json = {
        'name': 'Egg Dumplings',
        'description': 'A tasty egg-based dumpling dish.',
      };


      final dish = Dish.fromJson(json);


      expect(dish.name, 'Egg Dumplings');
      expect(dish.description, 'A tasty egg-based dumpling dish.');
      expect(dish.province, 'Unknown');
      expect(dish.imageUrl, '');
      expect(dish.simplifiedChinese, 'N/A');
      expect(dish.notes, 'N/A');
    });
  });
}