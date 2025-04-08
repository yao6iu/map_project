import 'package:html/parser.dart';
import 'package:menu_map/models/dish.dart';

class WikipediaParser {
  static List<Dish> parseDishesFromTable(String html, String cuisine) {


    final document = parse(html);
    final tables = document.querySelectorAll('table.wikitable');
    List<Dish> dishes = [];

    for (var table in tables) {
      final rows = table.querySelectorAll('tr');
      for (int i = 1; i < rows.length; i++) {
        final cells = rows[i].querySelectorAll('td');
        if (cells.length < 3) continue;

        try {
          String name = cells[0].text.trim();
          var imgElement = cells[1].querySelector('img');
          String imageUrl = imgElement != null
              ? 'https:${imgElement.attributes['src'] ?? ''}'
              : '';

          String notes = 'nothing';
          String description = 'nothing';
          String simplified = 'nothing';

          if (cuisine == 'Hunan') {
            if (cells.length > 2) {
              simplified = cells[2].text.trim().replaceAll(RegExp(r'[a-zA-Z]'), '');
              description = cells[2].text.trim().replaceAll(RegExp(r'\[\d+\]'), '');
            }
          } else if (cuisine == 'Jiangsu') {
            if (cells.length > 2) {
              var zhSpan = cells[2].querySelector('span[lang="zh-Hans"]');
              simplified = zhSpan != null
                  ? zhSpan.text.trim()
                  : cells[2].text.trim().replaceAll(RegExp(r'\[\d+\]'), '');
              description = cells[2].text.trim();
            }
          } else if (cuisine == 'Zhejiang') {
            if (cells.length > 1) {
              var zhSpan = cells[1].querySelector('span[lang="zh-Hans"]');
              simplified = zhSpan != null
                  ? zhSpan.text.trim()
                  : cells[1].text.trim().replaceAll(RegExp(r'\[\d+\]'), '');
              description = cells[1].text.trim();
            }
          } else if (cuisine == 'Fujian') {
            if (cells.length > 2) {
              simplified = cells[1].text.trim().replaceAll(RegExp(r'\[\d+\]'), '');
              description = cells[2].text.trim().replaceAll(RegExp(r'\[\d+\]'), '');
            }
          } else if (cuisine == 'Anhui') {
            if (cells.length > 4) {
              name = cells[0].text.trim();
              simplified = cells[2].text.trim().replaceAll(RegExp(r'\[\d+\]'), '');
              description = cells[4].text.trim().replaceAll(RegExp(r'\[\d+\]'), '');
              notes = description;
            }
          } else {
            if (cells.length > 3) {
              var zhSpan = cells[3].querySelector('span[lang="zh-Hans"]');
              simplified = zhSpan != null
                  ? zhSpan.text.trim()
                  : cells[3].text.trim().replaceAll(RegExp(r'\[\d+\]'), '');
              description = cells[3].text.trim();
            }
          }

          if (cells.length > 5) {
            notes = cells[5].text.trim().replaceAll(RegExp(r'\[\d+\]'), '');
          }

          if (name.isEmpty) continue;

          dishes.add(Dish(
            name: name,
            description: description,
            simplifiedChinese: simplified,
            notes: notes,
            province: cuisine,
            imageUrl: imageUrl,
          ));
        } catch (e) {
          print('line $i parsing failed: $e');
        }
      }

      if (dishes.isNotEmpty) break;
    }

    return dishes;
  }
}