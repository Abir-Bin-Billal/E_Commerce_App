import 'dart:convert';
import 'package:e_commerce_app/Contants/common_toast.dart';
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
}
