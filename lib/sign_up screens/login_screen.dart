import 'package:e_commerce_app/Contants/common-button.dart';
import 'package:e_commerce_app/Contants/common_toast.dart';
import 'package:e_commerce_app/Contants/loading_indicator.dart';
import 'package:e_commerce_app/api_services/api_pref.dart';
import 'package:e_commerce_app/api_services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';

import 'home_screen.dart';

class login_Screen extends StatefulWidget {
  login_Screen({super.key});

  @override
  State<login_Screen> createState() => _login_ScreenState();
}

class _login_ScreenState extends State<login_Screen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode usernameNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  ValueNotifier obsecurePassword = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please write something";
                    }
                    return null;
                  },
                  controller: usernameController,
                  focusNode: usernameNode,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Enter Username", hintText: "Username"),
                  onFieldSubmitted: (v) {
                    FocusScope.of(context).requestFocus(passwordNode);
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                ValueListenableBuilder(
                    valueListenable: obsecurePassword,
                    builder: (context, value, index) {
                      return TextFormField(
                          controller: passwordController,
                          focusNode: passwordNode,
                          obscureText: obsecurePassword.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please write something";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  obsecurePassword.value =
                                      !obsecurePassword.value;
                                },
                                child: obsecurePassword.value == true
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility)),
                            labelText: "Enter Password",
                            hintText: "Password",
                          ),
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).requestFocus(passwordNode);
                          });
                    }),
                SizedBox(
                  height: 20,
                ),
                common_button(
                    child: isLoading ? loadingIndicator() : Text("Login"),
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        commonToast("valided");
                        setState(() {
                          isLoading = true;
                        });
                        ApiServices()
                            .userlogin(usernameController.text.toString(),
                                passwordController.text.toString())
                            .then((value) {
                          debugPrint(value.toString());
                          ApiPref().setUserToken(value["token"].toString());
                          Get.offAll(() => homeScreen());
                          setState(() {
                            isLoading = false;
                          });
                        }).onError((error, stackTrace) {
                          setState(() {
                            isLoading = false;
                          });
                          debugPrint(error.toString());
                        });
                      } else {
                        commonToast("Invalid Credintial");
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
