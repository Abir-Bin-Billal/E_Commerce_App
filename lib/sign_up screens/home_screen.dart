import 'package:e_commerce_app/api_services/api_pref.dart';
import 'package:e_commerce_app/sign_up%20screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home screen"),
        actions: [
          IconButton(
              onPressed: () {
                ApiPref().removeUserToken();
                Get.offAll(() => login_Screen());
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
      ),
    );
  }
}
