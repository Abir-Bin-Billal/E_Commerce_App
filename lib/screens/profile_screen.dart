import 'package:e_commerce_app/Contants/common_toast.dart';
import 'package:e_commerce_app/models/user_Detail_model';
import 'package:flutter/material.dart';

import '../api_services/api_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserDetailModel userDetailModel = UserDetailModel();
  bool isLoading = true;

  getUserDetail() {
    ApiServices().getUserDetail("1").then((value) {
      userDetailModel = value;
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
    getUserDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text(
            "Profile",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 15),
        children: [
          Text("Personal Details" , style: TextStyle(color: Colors.blue , fontWeight: FontWeight.bold , fontSize: 20),),
          Container(
            margin: EdgeInsets.only(top: 10 , bottom: 20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name : ${userDetailModel.name!.firstname}${userDetailModel.name!.lastname}" , style: TextStyle(fontSize: 16),),
                Text("Phone : ${userDetailModel.phone}", style: TextStyle(fontSize: 16)),
                Text("Email : ${userDetailModel.email}", style: TextStyle(fontSize: 16)),

              ],
            ),
          ),
          Text("Personal Details" , style: TextStyle(color: Colors.blue , fontWeight: FontWeight.bold , fontSize: 20),),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name : ${userDetailModel.address!.city}" , style: TextStyle(fontSize: 16),),
                Text("Phone : ${userDetailModel.address!.street}", style: TextStyle(fontSize: 16)),
                Text("Email : ${userDetailModel.address!.zipcode}", style: TextStyle(fontSize: 16)),
                Text("Name : ${userDetailModel.address!.geolocation}" , style: TextStyle(fontSize: 16),),
                Text("Phone : ${userDetailModel.address!.number}", style: TextStyle(fontSize: 16))

              ],
            ),
          ),
        ],
      ),
    );
  }
}
