
import 'package:flutter/material.dart';
import 'package:menu_map/screens/china_map_page.dart';
import 'package:menu_map/screens/recommended_dishes_page.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({Key ? key}) : super(key: key);

  void navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menu Map")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => navigateTo(context, ChinaMapPage()),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20)),
                child: const Text('China Map', style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => navigateTo(context, RecommendedDishesPage()),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20)),
                child: const Text('Recommended Dishes',
                    style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}













