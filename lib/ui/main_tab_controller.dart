import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sparta_marketplace/core/util/theme_colors.dart';
import 'package:sparta_marketplace/ui/pages/home-screen-by-stores.dart';
import 'package:sparta_marketplace/ui/pages/order_screen.dart';
import 'package:sparta_marketplace/ui/pages/profile_page.dart';

class MainTabController extends StatefulWidget {
  @override
  _MainTabControllerState createState() => _MainTabControllerState();
  int pos = 0;
  Widget page;

  MainTabController({this.page, this.pos});
}

class _MainTabControllerState extends State<MainTabController> {
  List<TabItem> tabItems = List.of([
    new TabItem(Icons.home, "Início", ThemeColorsUtil.accentColor,
        labelStyle:
            TextStyle(color: ThemeColorsUtil.accentColor, fontSize: 11)),
    new TabItem(Icons.list, "Pedidos", ThemeColorsUtil.accentColor,
        labelStyle:
            TextStyle(color: ThemeColorsUtil.accentColor, fontSize: 11)),
    new TabItem(Icons.account_circle, "Perfil", ThemeColorsUtil.accentColor,
        labelStyle:
            TextStyle(color: ThemeColorsUtil.accentColor, fontSize: 11)),
  ]);

  CircularBottomNavigationController _navigationController =
      CircularBottomNavigationController(2);

  @override
  Widget build(BuildContext context) {
    widget.page ??= Container(
      child: HomeScreenByStores(),
    );
    return Scaffold(
      backgroundColor: Colors.black87,
      body: widget.page,
      bottomNavigationBar: CircularBottomNavigation(
        tabItems,
        barBackgroundColor: ThemeColorsUtil.primaryColor,
        barHeight: 50,
        controller: _navigationController,
        selectedCallback: (int selectedPos) {
          callPage(selectedPos);
        },
      ),
    );
  }

  void callPage(int selectedPos) {
    setState(() {
      widget.pos = selectedPos;
      switch (widget.pos) {
        case 0:
          widget.page = HomeScreenByStores();
          break;
        case 1:
          widget.page = OrderScreen();
          break;
        case 2:
          widget.page = ProfilePage();
          break;
      }
    });
  }
}
