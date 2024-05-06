import 'package:e_commerce_app/models/produuct_category_model.dart';
import 'package:e_commerce_app/screens/product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Contants/common-button.dart';
import '../Contants/common_toast.dart';
import '../Contants/loading_indicator.dart';
import '../api_services/api_service.dart';

class ProductcategoryScreen extends StatefulWidget {
  final String categoryName;
  const ProductcategoryScreen({super.key, required this.categoryName});

  @override
  State<ProductcategoryScreen> createState() => _ProductcategoryScreenState();
}

class _ProductcategoryScreenState extends State<ProductcategoryScreen> {
  List<ProductCategoryModel> productCategoryModel = [];
  bool isLoading = true;

  getCategoryProduts() {
    ApiServices().getcategoryproduct(widget.categoryName).then((value) {
      productCategoryModel = value;
      setState(() {
        isLoading = false;
      });
      debugPrint(value.toString());
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      commonToast("Login APi error");
    });
  }

  void initState() {
    getCategoryProduts();
    super.initState();
  }



  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.white,),
          backgroundColor: Colors.blue,
          title: Center(
            child: Text(
              "Products",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: isLoading
            ? Center(
          child: loadingIndicator(color :Colors.black),
        )
            : ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            itemCount: productCategoryModel.length,
            separatorBuilder: (context, i) {
              return SizedBox(
                height: 8,
              );
            },
            itemBuilder: (context, index) {
              final data = productCategoryModel[index];
              return GestureDetector(
                onTap: (){
                  Get.to(() => ProductDetails(productID: data.id,productName: data.title,));
                },
                child: Card(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                margin: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    image: DecorationImage(image: NetworkImage(data.image.toString()) , fit: BoxFit.cover)
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data.title.toString() , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
                                    Text("Price: ${data.price.toString()}" , style: TextStyle(fontSize: 14 , fontWeight: FontWeight.w400),),
                                    Text("Rating ${data.rating?.rate.toString()}" , style: TextStyle(fontSize: 14 , fontWeight: FontWeight.w400),),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 30),
                          child: Text(data.description.toString() , style: TextStyle(fontSize: 14 , fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                          child: common_button(
                              child: Text("Buy Now"),
                              onTap: (){}
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      );;
    }

}
