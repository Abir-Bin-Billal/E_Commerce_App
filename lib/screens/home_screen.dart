import 'package:e_commerce_app/Contants/common-button.dart';
import 'package:e_commerce_app/Contants/common_toast.dart';
import 'package:e_commerce_app/Contants/loading_indicator.dart';
import 'package:e_commerce_app/api_services/api_service.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/screens/product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> products = [];
  bool isLoading = true;

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
      body: isLoading
          ? Center(
              child: loadingIndicator(Colors.black),
            )
          : ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              itemCount: products.length,
              separatorBuilder: (context, i) {
                return SizedBox(
                  height: 8,
                );
              },
              itemBuilder: (context, index) {
                final data = products[index];
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
    );
  }
}
