import 'package:e_commerce_app/Contants/common_toast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

void handlePaymentSuccess(PaymentSuccessResponse response) {
  commonToast("payment success");
}

void handlePaymentError(PaymentFailureResponse response) {
  commonToast("payment failed");
}

void handleExternalWallet(ExternalWalletResponse response) {
 commonToast("External Wallet");
}
