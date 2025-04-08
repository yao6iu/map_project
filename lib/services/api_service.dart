import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:menu_map/models/dish.dart';
import 'package:menu_map/services/wikipedia_parser.dart';

class WikipediaAPI {
  static const String _baseUrl = 'https://en.wikipedia.org/w/api.php';

  Map<String, dynamic>? _getCuisineConfig(String cuisine) {
    final cuisineConfigs = {
      'Cantonese': {'page': 'Cantonese_cuisine', 'section': 5},
      'Sichuan': {'page': 'Sichuan_cuisine', 'section': 6},
      'Jiangsu': {'page': 'Jiangsu_cuisine', 'section': 2},
      'Zhejiang': {'page': 'Zhejiang_cuisine', 'section': 2},
      'Fujian': {'page': 'Fujian_cuisine', 'section': 3},
      'Hunan': {'page': 'Hunan_cuisine', 'section': 3},
      'Anhui': {'page': 'Anhui_cuisine', 'section': 2},
    };
    return cuisineConfigs[cuisine];
  }

  Future<List<Dish>> fetchDishes(String cuisine) async {
    final config = _getCuisineConfig(cuisine);
    if (config == null) {
      throw Exception('Unsupported cuisine: $cuisine');
    }

    final uri = Uri.parse(
      '$_baseUrl?action=parse&format=json&prop=text&section=${config['section']}&origin=*&page=${config['page']}',
    );

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return _parseContent(jsonDecode(response.body), cuisine);
    } else {
      throw Exception('Failed to load dishes: ${response.statusCode}');
    }
  }

  List<Dish> _parseContent(Map<String, dynamic> json, String cuisine) {
    final content = json['parse']?['text']?['*'] as String? ?? '';
    print('Parsed Content: $content');
    return WikipediaParser.parseDishesFromTable(content, cuisine);
  }

  // 公共方法，用于测试时调用
  List<Dish> parseDishesFromJson(Map<String, dynamic> json, String cuisine) {
    return _parseContent(json, cuisine);
  }

  static String buildDirectLink(String cuisine) {
    final config = WikipediaAPI()._getCuisineConfig(cuisine);
    if (config == null) throw Exception('Unsupported cuisine: $cuisine');
    return 'https://en.wikipedia.org/wiki/${config['page']}#${config['section']}';
  }
}