import 'package:flutter/material.dart';
import 'package:menu_map/Screens/map_screen.dart';


void main() {
  runApp(MenuMapApp());
}

class MenuMapApp extends StatelessWidget {
  const MenuMapApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu Map',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MapScreen(),
    );
  }
}