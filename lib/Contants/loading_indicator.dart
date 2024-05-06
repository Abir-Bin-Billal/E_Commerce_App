import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'dart:ui';

class loadingIndicator extends StatelessWidget {
  const loadingIndicator({super.key, required this.color, this.bgcolor});
  final Color color;
  final bgcolor;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 30,
        width: 60,
        child: LoadingIndicator(
            indicatorType: Indicator.ballPulse,
            colors: [color],
            strokeWidth: 2,
            backgroundColor: bgcolor?? Colors.white,
            pathBackgroundColor: Colors.blue),
      ),
    );
    ;
  }
}
