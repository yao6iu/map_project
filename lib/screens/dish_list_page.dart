import 'package:flutter/material.dart';
import 'package:menu_map/models/dish.dart';
import 'package:menu_map/services/api_service.dart';
import 'package:menu_map/screens/dish_details_page.dart';

class DishListPage extends StatefulWidget {
  final String cuisine;
  const DishListPage({Key? key, required this.cuisine}) : super(key: key);

  @override
  _DishListPageState createState() => _DishListPageState();
}

class _DishListPageState extends State<DishListPage> {
  List<Dish> dishes = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchDishes();
  }

  Future<void> fetchDishes() async {
    try {
      List<Dish> results = await WikipediaAPI().fetchDishes(widget.cuisine);
      if (results.isEmpty) {
        setState(() {
          errorMessage = 'No dishes found for ${widget.cuisine} cuisine.';
          isLoading = false;
        });
      } else {
        setState(() {
          dishes = results;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load data: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  void navigateToDetails(Dish dish) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DishDetailsPage(dish: dish),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.cuisine} Cuisine Dishes')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage, style: const TextStyle(fontSize: 16)))
          : ListView.builder(
            itemCount: dishes.length,
            itemBuilder: (context, index) {
              final dish = dishes[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: dish.imageUrl.isNotEmpty
                ? Image.network(
                  dish.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
                : Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported),
                ),
                title: Text(dish.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text(dish.simplifiedChinese.isNotEmpty && dish.simplifiedChinese != 'N/A'
                ? dish.simplifiedChinese
                : 'No Simplified Chinese Available'),
              onTap: () => navigateToDetails(dish),
              );
            },
          ),
    );
  }
}