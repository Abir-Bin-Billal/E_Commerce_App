import 'package:e_commerce_app/Contants/common-button.dart';
import 'package:e_commerce_app/Contants/loading_indicator.dart';
import 'package:e_commerce_app/models/single_product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:e_commerce_app/Contants/razorpay_handler.dart';
import '../Contants/common_toast.dart';
import '../api_services/api_service.dart';

class ProductDetails extends StatefulWidget {
  final productID;
  final productName;
  const ProductDetails({super.key, this.productID, this.productName});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  SingleProductModel singleProductModel = SingleProductModel();

  bool isLoading = false;

  getProduts() {
    ApiServices().getSingleproduct(widget.productID).then((value) {
      singleProductModel = value;
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
    getProduts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: BackButton(color: Colors.white,),
        title: Center(
          child: Text(
            widget.productName ,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: isLoading?Center(child: loadingIndicator(color: Colors.blue),):
      ListView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(singleProductModel.image.toString()))
            ),
          ),
          Divider(),
          Text(singleProductModel.title.toString() , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold),),
          Text("Price: ${singleProductModel.price.toString()}" , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w500),),
          Text("Rating ${singleProductModel.rating?.rate.toString()}" , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w500),),
          Text("Category: ${singleProductModel.category.toString()}" , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w500),),
          SizedBox(height: 20,),
          Text("Description: ${singleProductModel.description.toString()}" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),)

        ],
      ),
      bottomSheet:  Container(
          height: 50,
          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: common_button(child: Text("Buy Now"),onTap: (){
             Razorpay razorpay = Razorpay();
                  var options = {
                    'key': 'rzp_test_1DP5mmOlF5G5ag',
                    'amount': singleProductModel.price,
                    'name': 'Acme Corp.',
                    'description': singleProductModel.title,
                    'retry': {'enabled': true, 'max_count': 1},
                    'send_sms_hash': true,
                    'prefill': {
                      'contact': '8888888888',
                      'email': 'test@razorpay.com'
                    },
                    'external': {
                      'wallets': ['paytm']
                    }
                  };
                  razorpay.on(
                      Razorpay.EVENT_PAYMENT_ERROR, handlePaymentSuccess);
                  razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                      handlePaymentError);
                  razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                      handleExternalWallet);
                  razorpay.open(options);
          },)
      ),
    );
  }
}
