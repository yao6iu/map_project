import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:menu_map/models/dish.dart';
import 'package:menu_map/services/wikipedia_parser.dart';
import 'package:menu_map/constants/cuisines.dart';

class WikipediaAPI {
  static const String _baseUrl = 'https://en.wikipedia.org/w/api.php';

  final http.Client httpClient;
  WikipediaAPI({http.Client? client})
      : httpClient = client ?? http.Client();

  Future<List<Dish>> fetchDishes(String cuisine) async {
    final config = cuisineConfig[cuisine];
    if (config == null) {
      throw ArgumentError('Unsupported cuisine: $cuisine');
    }

    final uri = Uri.parse(
      '$_baseUrl?action=parse'
          '&format=json&prop=text'
          '&section=${config['section']}'
          '&origin=*&page=${config['page']}',
    );

    final response = await httpClient.get(uri);
    if (response.statusCode != 200) {
      throw http.ClientException(
          'Failed to load: ${response.statusCode}', uri);
    }

    final jsonMap = jsonDecode(response.body) as Map<String, dynamic>;
    // The production code is also called parser.parse
    return WikipediaParser.parseDishesFromJson(jsonMap, cuisine);
  }
}