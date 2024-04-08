import 'package:e_commerce_app/sign_up%20screens/splash_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Myapp());
}
class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: splash_Screen(),
    );
  }
}
