import 'package:flutter/services.dart';
import 'package:html/parser.dart';

class APIService {

  Future<List<Map<String, String>>> loadNotableFoodsFromAssets(String category) async {
    try {

      String htmlContent = await rootBundle.loadString('assets/Sichuan_cuisine.html');


      final doc = parse(htmlContent);

      List<Map<String, String>> dishes = [];
      final foodItems = doc.querySelectorAll('ul li');

      for (var item in foodItems) {
        final titleElement = item.querySelector('a');
        final title = titleElement != null ? titleElement.text : item.text.split('\n').first;
        final description = item.text.trim();
        final imageUrl = '';

        dishes.add({
          'title': title,
          'description': description,
          'image': imageUrl,
        });
      }

      return dishes;
    } catch (e) {
      throw Exception('Error loading data from assets: $e');
    }
  }
}
