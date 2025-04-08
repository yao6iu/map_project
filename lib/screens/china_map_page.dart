import 'package:flutter/material.dart';
import 'package:menu_map/screens/dish_list_page.dart';

class ChinaMapPage extends StatelessWidget {
  const ChinaMapPage({Key? key}) : super(key: key);

  void onProvinceTap(BuildContext context, String cuisine) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DishListPage(cuisine: cuisine)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('China Map')),
      body: Center(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/china_map.png',
              fit: BoxFit.contain,
              width: double.infinity,
            ),
            // 四川区域
            Positioned(
              left: 100,
              top: 200,
              child: GestureDetector(
                onTap: () => onProvinceTap(context, 'Sichuan'),
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.red.withOpacity(0.3),
                  child: const Center(
                    child: Text(
                      'Sichuan',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            // 江苏区域
            Positioned(
              left: 200,
              top: 150,
              child: GestureDetector(
                onTap: () => onProvinceTap(context, 'Jiangsu'),
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.green.withOpacity(0.3),
                  child: const Center(
                    child: Text(
                      'Jiangsu',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            // 如果需要，也可以添加其他区域
          ],
        ),
      ),
    );
  }
}