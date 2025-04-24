import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:menu_map/services/api_service.dart';
import 'package:menu_map/models/dish.dart';
import 'package:menu_map/constants/cuisines.dart';

void main() {
  group('WikipediaAPI.fetchDishes', () {
    late WikipediaAPI api;

    setUp(() {
      final fixture = File('test/assets/dish_response.json').readAsStringSync();
      final mockClient = MockClient((_) async {
        // Use bytes instead of plain Strings to support non-Latin1 characters.
        return Response.bytes(
          utf8.encode(fixture),
          200,
          headers: {'content-type': 'application/json; charset=utf-8'},
        );
      });
      api = WikipediaAPI(client: mockClient);
    });

    test('returns a list of Dish for Anhui (from local JSON)', () async {
      final dishes = await api.fetchDishes(CuisineName.anhui);

      expect(dishes, isA<List<Dish>>());
      expect(dishes.length, 1);
      final dish = dishes.first;
      expect(dish.name, 'Egg dumplings');
      expect(dish.simplifiedChinese, '农家蛋饺');
      expect(dish.description.startsWith('These dumplings'), isTrue);
      expect(dish.province, CuisineName.anhui);
    });

    test('throws on unsupported cuisine', () {
      expect(
            () => api.fetchDishes('UnknownCuisine'),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}