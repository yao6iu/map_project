import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:menu_map/models/dish.dart';
import 'package:menu_map/services/wikipedia_parser.dart';

void main() {
  group('Dish Model from WikipediaParser', () {
    test('parses a single Dish correctly from local JSON fixture', () {
      final jsonString = File('test/assets/dish_response.json').readAsStringSync();
      final jsonData = json.decode(jsonString);

      final dishes = WikipediaParser.parseDishesFromJson(jsonData, 'Anhui');

      expect(dishes, isA<List<Dish>>());
      expect(dishes.length, 1);

      final dish = dishes.first;
      expect(dish.name, 'Egg dumplings');
      expect(dish.simplifiedChinese, '农家蛋饺');
      expect(dish.notes, contains('These dumplings, usually associated'));
      expect(dish.description, equals(dish.notes)); // notes = description
      expect(dish.province, 'Anhui');
    });

    test('throws FormatException if no table found in JSON', () {
      final jsonData = {
        "parse": {
          "text": {
            "*": "<p>No table here!</p>"
          }
        }
      };

      expect(() => WikipediaParser.parseDishesFromJson(jsonData, 'FakeCuisine'),
          throwsA(isA<FormatException>()));
    });
  });
}