import 'package:e_commerce_app/Contants/common-button.dart';
import 'package:e_commerce_app/Contants/common_toast.dart';
import 'package:e_commerce_app/Contants/loading_indicator.dart';
import 'package:e_commerce_app/api_services/api_service.dart';
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
        leading: BackButton(color: Colors.white,),
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
                    child: isLoading ? loadingIndicator() : Text("register"),
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                       
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
