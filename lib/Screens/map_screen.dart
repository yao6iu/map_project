import 'package:menu_map/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:menu_map/models/dish.dart';
import 'package:menu_map/widgets/dish_details_dialog.dart';

class MapScreen extends StatelessWidget{
  const MapScreen({Key ? key}) : super(key: key);

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
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => navigateTo(context, const RecommendedRestaurantsPage()),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20)),
                child: const Text('Recommended Restaurants',
                    style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChinaMapPage extends StatelessWidget{
  const ChinaMapPage({Key ? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('China Map')),
      body: Center(
        child: Image.asset('assets/images/china_map.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class RecommendedDishesPage extends StatelessWidget{
  const RecommendedDishesPage({Key ? key}) : super(key: key);

  void navigateToCategory(BuildContext context, String category) {
    String wikiCategory = "${category} cuisine";
    Navigator.push(
      context, MaterialPageRoute(
        builder: (context) => DishListPage(category: wikiCategory),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> cuisines = [
      'Sichuan', 'Shandong', 'Cantonese', 'Jiangsu', 'Zhejiang', 'Fujian', 'Hunan', 'Anhui'];
    return Scaffold(
      appBar: AppBar(title: const Text('Recommended Dishes')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: cuisines.map((cuisine) => Padding(
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
          )).toList(),
        ),
      ),
    );
  }
}


class DishListPage extends StatefulWidget {
  final String category;
  const DishListPage({Key? key, required this.category}) : super(key: key);

  @override
  _DishListPageState createState() => _DishListPageState();
}

class _DishListPageState extends State<DishListPage> {
  List<Map<String, String>> dishes = [];
  bool isLoading = true;
  String errorMessage = '';
  final APIService apiService = APIService();

  @override
  void initState() {
    super.initState();
    fetchDishes();
  }

  Future<void> fetchDishes() async {
    try {
      List<Map<String, String>> results = await apiService.loadNotableFoodsFromAssets('Sichuan_cuisine');

      setState(() {
        dishes = results;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }



  void _showDishDetails(Map<String, String> dishData) async {
    Navigator.push(
      context, MaterialPageRoute(
        builder: (context) => DishDetailsPage(dish: dishData)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.category} Notable Foods')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage))
          : ListView.builder(
        itemCount: dishes.length,
        itemBuilder: (context, index) {
          final dish = dishes[index];
          return ListTile(
            title: Text(dish['title']!),
            subtitle: Text(dish['description']!),
            onTap: () => _showDishDetails(dish),
          );
        },
      ),
    );
  }
}

class DishDetailsPage extends StatelessWidget{
  final Map<String, String> dish;
  const DishDetailsPage({Key? key, required this.dish}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(dish['title']!)),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dish['image']!.isNotEmpty
                  ? Image.network(dish['image']!)
                  : Container(height: 200, color: Colors.grey[300]),
              const SizedBox(height: 8),
              Text(dish['description']!, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text('Province: ${dish['province'!]}', style: const TextStyle(fontSize: 14)),
            ],
          ),
      ),
    );
  }
}

class RecommendedRestaurantsPage extends StatelessWidget {
  const RecommendedRestaurantsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recommended Restaurants')),
      body: const Center(
        child: Text('Recommended Restaurants Page - Under Construction'),
      ),
    );
  }
}



