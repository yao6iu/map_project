import 'package:flutter/material.dart';
import 'package:menu_map/models/dish.dart';

class DishDetailsDialog extends StatelessWidget {
  final Dish dish;

  const DishDetailsDialog({Key? key, required this.dish}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(dish.name),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dish.imageUrl.isNotEmpty
                ? Image.network(dish.imageUrl)
                : Container(),
            const SizedBox(height: 8),
            Text(dish.description),
            const SizedBox(height: 8),
            Text('Province: ${dish.province}'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}