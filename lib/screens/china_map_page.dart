import 'package:flutter/material.dart';
import 'package:menu_map/screens/dish_list_page.dart';

class ChinaMapPage extends StatelessWidget {
  const ChinaMapPage({Key? key}) : super(key: key);

  void _onProvinceTap(BuildContext context, String cuisine) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DishListPage(cuisine: cuisine),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Offset> _provincePositions = {
      'Sichuan': const Offset(400, 385),
      'Cantonese': const Offset(600, 505),
      'Jiangsu': const Offset(660, 296),
      'Zhejiang': const Offset(680, 378),
      'Fujian': const Offset(675, 450),
      'Hunan': const Offset(550, 435),
      'Anhui': const Offset(645, 340),
      'Yunnan': const Offset(390, 500),
    };

    return Scaffold(
      appBar: AppBar(title: const Text('China Map')),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.7,
          child: Stack(
            children: [
            // Base map image
              Positioned.fill(
                child: Image.asset(
                  'assets/china_map.jpg',
                  fit: BoxFit.cover,
                  ),
                ),
            // Province buttons
              for (var entry in _provincePositions.entries)
                Positioned(
                  left: entry.value.dx,
                  top: entry.value.dy,
                  child: GestureDetector(
                    onTap: () => _onProvinceTap(context, entry.key),
                    child: Container(
                      width: 100,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.red[800],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        entry.key,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
