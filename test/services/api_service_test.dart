import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:menu_map/services/api_service.dart';
import 'package:menu_map/models/dish.dart';

void main() {
  group('WikipediaAPI Tests', () {
    test('fetchDishes should return a list of dishes from local JSON file', () async {
      // 读取本地 JSON 文件，路径为 test/assets/dish_response.json
      final File file = File('test/assets/dish_response.json');
      final String testFileContents = await file.readAsString();
      final Map<String, dynamic> mockJson = jsonDecode(testFileContents);

      // 使用新的公共方法 parseDishesFromJson 来解析 JSON 数据
      final wikipediaAPI = WikipediaAPI();
      final List<Dish> dishes = wikipediaAPI.parseDishesFromJson(mockJson, 'Anhui');

      // 验证返回的 Dish 对象是否符合预期
      expect(dishes.length, 1);
      expect(dishes[0].name, 'Egg dumplings');
      expect(dishes[0].simplifiedChinese, '农家蛋饺');
      expect(dishes[0].description,
          'These dumplings, usually associated with rural cooking, use thin sheets of egg instead of flour for the wrapping. Egg dumplings traditionally use pork as a filling. In preparation, a ladle is lightly coated with oil and heated, well beaten eggs are spooned into the ladle and cooked until the mixture forms a dumpling wrapper. The pork filling is then spooned into the egg wrapping and the entire dumpling steamed. It is often served with soy sauce.');
      expect(dishes[0].province, 'Anhui');
    });
  });
}