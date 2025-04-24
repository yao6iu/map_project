import 'package:html/parser.dart';
import 'package:menu_map/models/dish.dart';

class WikipediaParser {
  /// Shared entry for production and testing
  static List<Dish> parseDishesFromJson(
      Map<String, dynamic> json, String cuisine) {
    final html = json['parse']?['text']?['*'] as String? ?? '';
    if (!html.contains('<table')) {
      throw FormatException('No table found for $cuisine');
    }
    return _parseDishesFromTable(html, cuisine);
  }

  static List<Dish> _parseDishesFromTable(String html, String cuisine) {
    final document = parse(html);
    final tables = document.querySelectorAll('table.wikitable');
    final dishes = <Dish>[];

    for (final table in tables) {
      // First, read the header
      final headerRow = table.querySelector('tr');
      if (headerRow == null) continue;
      final headers =
      headerRow.querySelectorAll('th').map((th) => th.text.trim()).toList();

      // Second, dynamically search for the indexes of each column
      int idxName = _findHeaderIndex(headers, ['English', 'Dish', 'Name']);
      int idxImage = _findHeaderIndex(headers, ['Image', 'Photo']);
      int idxSimp = headers.indexWhere(
              (h) => h.toLowerCase() == 'simplified chinese');
      int idxDesc = _findHeaderIndex(headers, ['description', 'notes',]);

      // If it couldn't find 'idxName',then skip this table
      if (idxName < 0) continue;

      // Third, analyze each line
      for (final row in table.querySelectorAll('tr').skip(1)) {
        final cells = row.querySelectorAll('td');
        if (cells.length <= idxName) continue;

        try {
          // the dish name
          final name = cells[idxName].text.trim();

          // Image
          String imageUrl = '';
          if (idxImage >= 0 && idxImage < cells.length) {
            final img = cells[idxImage].querySelector('img');
            final src = img?.attributes['src'];
            if (src != null) imageUrl = 'https:$src';
          }

          // Simplified Chinese
          String simplified = '';
          if (idxSimp >= 0 && idxSimp < cells.length) {
            final span =
            cells[idxSimp].querySelector('span[lang="zh-Hans"]');
            simplified = (span?.text.trim() ?? cells[idxSimp].text.trim());
          }

          // Description / Notes
          String description = '';
          if (idxDesc >= 0 && idxDesc < cells.length) {
            description = cells[idxDesc].text.trim();
          }
          final notes = description;

          if (name.isNotEmpty) {
            dishes.add(Dish(
              name: name,
              description: description,
              simplifiedChinese: simplified,
              notes: notes,
              province: cuisine,
              imageUrl: imageUrl,
            ));
          }
        } on Exception catch (e) {
          throw FormatException('Row parse failed for $cuisine: $e');
        }
      }

      if (dishes.isNotEmpty) break;
    }

    return dishes;
  }

  /// Find the index of the first header that contains any keyword. If no such header is found, return -1
  static int _findHeaderIndex(List<String> headers, List<String> keywords) {
    for (var i = 0; i < headers.length; i++) {
      final h = headers[i].toLowerCase();
      for (final kw in keywords) {
        if (h.contains(kw.toLowerCase())) {
          return i;
        }
      }
    }
    return -1;
  }
}