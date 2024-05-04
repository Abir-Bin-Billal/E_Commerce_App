import 'dart:convert';
import 'package:e_commerce_app/Contants/common_toast.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/models/produuct_category_model.dart';
import 'package:e_commerce_app/models/single_product_model.dart';
import 'package:e_commerce_app/models/user_registration_model.dart';
import 'package:e_commerce_app/sign_up%20screens/user_register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static String baseUrl = "https://fakestoreapi.com";

// User Login API
  Future<dynamic> userlogin(String username, String password) async {
    var respose = await http.post(Uri.parse("$baseUrl/auth/login"),
        body: {"username": username, "password": password});
    if (respose.statusCode == 200) {
      return jsonDecode(respose.body);
    } else {
      throw commonToast("Invalid");
    }
  }
  //User registration API

  Future<dynamic> userRegister(UserRegistrationModel userRegistrationModel) async {
    var respose = await http.post(Uri.parse("$baseUrl/users"),
        body: jsonEncode(userRegistrationModel));
    if (respose.statusCode == 200) {
      return jsonDecode(respose.body);
    } else {
      throw commonToast("Invalid");
    }
  }

  //User product model
  Future<List<ProductModel>> getAllproduct() async {
    var respose = await http.get(Uri.parse("$baseUrl/products"));
    if (respose.statusCode == 200) {
      return List<ProductModel>.from(
          json.decode(respose.body).map((x) =>  ProductModel.fromJson(x as Map<String , dynamic>)));
    } else {
      throw commonToast("Invalid");
    }
  }


  Future<SingleProductModel> getSingleproduct(int productID) async {
    var respose = await http.get(Uri.parse("$baseUrl/products/$productID"));
    if (respose.statusCode == 200) {
      return SingleProductModel.fromJson(json.decode(respose.body));
    } else {
      throw commonToast("Invalid");
    }
  }


  Future<dynamic> getAllCategories() async {
    var respose = await http.get(Uri.parse("$baseUrl/products/categories"));
    if (respose.statusCode == 200) {
      return jsonDecode(respose.body);
    } else {
      throw commonToast("Invalid");
    }
  }

  Future<List<ProductCategoryModel>> getcategoryproduct(String categoryName) async {
    var respose = await http.get(Uri.parse("$baseUrl/products/category/$categoryName"));
    if (respose.statusCode == 200) {
      return List<ProductCategoryModel>.from(
          json.decode(respose.body).map((x) =>  ProductCategoryModel.fromJson(x as Map<String , dynamic>)));
    } else {
      throw commonToast("Invalid");
    }
  }
}
