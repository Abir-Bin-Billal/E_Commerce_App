import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'dart:ui';

loadingIndicator() {
  return LoadingIndicator(
      indicatorType: Indicator.ballPulse,
      colors: const [Colors.white],
      strokeWidth: 2,
      backgroundColor: Colors.blue,
      pathBackgroundColor: Colors.blue);
}
