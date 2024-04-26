import 'package:e_commerce_app/api_services/api_pref.dart';
import 'package:e_commerce_app/screens/category_screen.dart';
import 'package:e_commerce_app/screens/home_screen.dart';
import 'package:e_commerce_app/screens/profile_screen.dart';
import 'package:e_commerce_app/sign_up%20screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';

class ButtomBarTabs extends StatefulWidget {
  const ButtomBarTabs({super.key});

  @override
  State<ButtomBarTabs> createState() => _ButtomBarTabsState();
}

class _ButtomBarTabsState extends State<ButtomBarTabs> {
  int _selectedindex = 0;
  static final List<Widget> WidgetTabs = [
    const HomeScreen(),
    const CategoryScreen(),
    const ProfileScreen()
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WidgetTabs[_selectedindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedindex,
        selectedItemColor: Colors.blue,
        onTap: onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home) , label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.category_outlined) , label: "Category"), 
          BottomNavigationBarItem(icon: Icon(Icons.person_3_outlined) , label: "Profile")
        ]),
    );
  }
}
