import 'package:flutter/material.dart';
import 'package:sparta_marketplace/ui/main_screen/main_tab_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MainTabController(),
    );
  }
}

