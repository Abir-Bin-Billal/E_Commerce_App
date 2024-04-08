

import 'package:e_commerce_app/Contants/common-button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class login_Screen extends StatefulWidget {
   login_Screen({super.key});

  @override
  State<login_Screen> createState() => _login_ScreenState();
}

class _login_ScreenState extends State<login_Screen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode usernameNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  ValueNotifier obsecurePassword = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400
              ),),
              SizedBox(height: 30,),
              TextField(
                controller: usernameController,
                focusNode: usernameNode,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Enter Username",
                  hintText: "Username"
                ),
                onSubmitted: (v){
                  FocusScope.of(context).requestFocus(passwordNode);
                },
              ),
          SizedBox(
            height: 40,
          ),
          ValueListenableBuilder(
            valueListenable: obsecurePassword,
            builder: (context , value , index) {
              return TextField(
                controller: passwordController,
                focusNode: passwordNode,
                obscureText: obsecurePassword.value,

                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                      onTap: (){
                        obsecurePassword.value = !obsecurePassword.value;
                      },
                      child: obsecurePassword.value == true?Icon(Icons.visibility_off): Icon(Icons.visibility)),

                    labelText: "Enter Password",
                  hintText: "Password",

                ),
                onSubmitted: (v) {
                  FocusScope.of(context).requestFocus(passwordNode);
                }
              );
            }
          ),
              SizedBox(height: 20,),
              common_button(child: Text("login"), onTap: (){})
            ],
          ),
        ),
      ),
    );
  }
}
