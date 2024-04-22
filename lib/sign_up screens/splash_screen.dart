import 'package:e_commerce_app/Contants/assets.dart';
import 'package:e_commerce_app/api_services/api_pref.dart';
import 'package:e_commerce_app/sign_up%20screens/home_screen.dart';
import 'package:e_commerce_app/sign_up%20screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class splash_Screen extends StatefulWidget {
  const splash_Screen({super.key});

  @override
  State<splash_Screen> createState() => _splash_ScreenState();
}

class _splash_ScreenState extends State<splash_Screen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      ApiPref().getuserToken().then((value) {
        if (value == "") {
          Get.offAll(() => login_Screen());
        } else {
          Get.offAll(() => homeScreen());
        }
      });
      Get.offAll(() => login_Screen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.network(
              "https://cdni.iconscout.com/illustration/premium/thumb/ecommerce-website-3613833-3025953.png")),
    );
  }
}
