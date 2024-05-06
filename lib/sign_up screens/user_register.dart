import 'package:e_commerce_app/Contants/assets.dart';
import 'package:e_commerce_app/Contants/common-button.dart';
import 'package:e_commerce_app/Contants/common_toast.dart';
import 'package:e_commerce_app/Contants/loading_indicator.dart';
import 'package:e_commerce_app/api_services/api_pref.dart';
import 'package:e_commerce_app/api_services/api_service.dart';
import 'package:e_commerce_app/models/user_registration_model.dart';
import 'package:e_commerce_app/screens/button_bar_tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';

class UserRegistrate extends StatefulWidget {
  const UserRegistrate({super.key});

  @override
  State<UserRegistrate> createState() => _UserRegistrateState();
}

class _UserRegistrateState extends State<UserRegistrate> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode usernameNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode cityNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        title: Center(
          child: Text(
            "Register",
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
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please write something";
                    }
                    return null;
                  },
                  controller: emailController,
                  focusNode: emailNode,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Enter Email", hintText: "Email"),
                  onFieldSubmitted: (v) {
                    FocusScope.of(context).requestFocus(usernameNode);
                  },
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
                TextFormField(
                    controller: passwordController,
                    focusNode: passwordNode,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please write something";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Enter Password",
                      hintText: "Password",
                    ),
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(cityNode);
                    }),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please write something";
                    }
                    return null;
                  },
                  controller: cityNameController,
                  focusNode: cityNode,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Enter City", hintText: "City"),
                  onFieldSubmitted: (v) {
                    FocusScope.of(context).requestFocus(cityNode);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                common_button(
                    child: isLoading ? loadingIndicator(color : Colors.white) : Text("register"),
                    onTap: () {
                      setState(() {
                        isLoading = true;
                      });
                      if (_formKey.currentState!.validate()) {
                        UserRegistrationModel userRegistrationModel =
                            UserRegistrationModel();
                        userRegistrationModel.email =
                            emailController.text.toString();
                        userRegistrationModel.username =
                            usernameController.text.toString();
                        userRegistrationModel.password =
                            passwordController.text.toString();
                        userRegistrationModel.name?.firstname = "John";
                        userRegistrationModel.name?.lastname = "Doe";
                        userRegistrationModel.address?.city = "kilcoole";
                        userRegistrationModel.address?.street = "kilcoole";
                        userRegistrationModel.address?.number = 3;
                        userRegistrationModel.address?.zipcode = "kilcoole";
                        userRegistrationModel.address?.geolocation?.lat =
                            "kilcoole";
                        userRegistrationModel.address?.geolocation?.long =
                            "dfbhb";
                        userRegistrationModel.phone = "ffdfdf";

                        ApiServices()
                            .userRegister(userRegistrationModel)
                            .then((value) {
                          debugPrint(value.toString());
                          ApiPref().setUserToken(value["id"].toString());

                          Get.offAll(() => ButtomBarTabs());

                          commonToast("Registration Successfull");
                        }).onError((error, stackTrace) {
                          setState(() {
                            isLoading = true;
                            debugPrint(error.toString());
                            commonToast("Something went wrong");
                          });
                        });
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
