import 'package:flutter/material.dart';
import 'package:menu_map/models/dish.dart';

class DishDetailsPage extends StatelessWidget {
  final Dish dish;

  const DishDetailsPage({Key? key, required this.dish}) : super(key: key);


  Map<String, String> _parseDescription(String description) {
    final lines = description.split('\n');
    String simplified = '';
    String notes = '';

    if (lines.isNotEmpty) {
      simplified = lines.firstWhere(
            (line) => line.contains('Simplified Chinese'),
        orElse: () => '',
      ).replaceFirst('Simplified Chinese:', '').trim();

      if (lines.length > 1) {
        notes = lines.firstWhere(
              (line) => line.contains('Notes'),
          orElse: () => '',
        ).replaceFirst('Notes:', '').trim();
      }
    }
    return {'simplified': simplified, 'notes': notes};
  }

  @override
  Widget build(BuildContext context) {
    final descParts = _parseDescription(dish.description);

    return Scaffold(
      appBar: AppBar(title: Text(dish.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dish.imageUrl.isNotEmpty
                  ? Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Image.network(
                      dish.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  )
                  : Container(
                    width: 150,
                    height: 150,
                    color: Colors.grey[300],
                    child: const Center(child: Text('No Image')),
                  ),
                  const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Simplified Chinese: ${dish.simplifiedChinese}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Province: ${dish.province}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Notes: ${dish.notes}',
                      style: const TextStyle(
                          fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}