import 'package:flutter/material.dart';
import 'package:menu_map/screens/dish_list_page.dart';

class RecommendedDishesPage extends StatelessWidget {
  const RecommendedDishesPage({Key? key}) : super(key: key);

  void navigateToCategory(BuildContext context, String cuisine) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DishListPage(cuisine: cuisine),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> cuisines = [
      'Sichuan', 'Yunnan', 'Cantonese', 'Jiangsu', 'Zhejiang', 'Fujian', 'Hunan', 'Anhui'
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Recommended Dishes')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: cuisines
                .map(
                  (cuisine) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => navigateToCategory(context, cuisine),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: Text(cuisine, style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            )
                .toList(),
          ),
        ),
      ),
    );
  }
}