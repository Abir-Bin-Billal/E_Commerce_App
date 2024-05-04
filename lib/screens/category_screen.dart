import 'package:e_commerce_app/screens/product_category_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Contants/common_toast.dart';
import '../Contants/loading_indicator.dart';
import '../api_services/api_service.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  dynamic category =[];
  bool isLoading = false;

  getAllCategory() {
    ApiServices().getAllCategories().then((value) {
      category = value;
      setState(() {
        isLoading = true;
      });
      debugPrint(value.toString());
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      commonToast("Login APi error");
    });
  }
@override
  void initState() {
  getAllCategory();
  super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.white,),
          backgroundColor: Colors.blue,
          title: Center(
            child: Text("Categories", style: TextStyle(
                color: Colors.white
            ),),
          ),
        ),
        body: isLoading == false? Center(child: loadingIndicator(Colors.blue),) :
        ListView.separated(
          itemCount: category.length,
          separatorBuilder: (context, i) {
            return Divider();
          },
          itemBuilder: (context, index) {
            return ListTile(
              onTap: (){
                Get.to(() => ProductcategoryScreen(categoryName: category[index].toString(),));
              },
              leading: CircleAvatar(
                child: Text(index.toString()),
              ),
              title: Text(category[index].toString()),
            );
          },)
    );
  }
}
