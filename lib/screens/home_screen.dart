import 'package:e_commerce_app/Contants/common_toast.dart';
import 'package:e_commerce_app/Contants/loading_indicator.dart';
import 'package:e_commerce_app/api_services/api_service.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> products = [];
  bool isLoading = false;

  getAllProduts() {
    ApiServices().getAllproduct().then((value) {
      products = value;
      setState(() {
        isLoading = false;
      });
      debugPrint(value.toString());
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      commonToast("Login APi error");
    });
  }

  @override
  void initState() {
    getAllProduts();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text(
            "Products",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: isLoading== false? Center(child: loadingIndicator(Colors.black),): 
      
      ListView.separated(
              itemCount: products.length,
              separatorBuilder: (context, i) {
                return SizedBox(
                  height: 10,
                );
              },
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.red,
                );
              }),
    );
  }
}
