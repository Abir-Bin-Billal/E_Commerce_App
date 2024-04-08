import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class common_button extends StatelessWidget {
  final dynamic child;
  final VoidCallback onTap;
  const common_button({super.key , required this.child , required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton(
        child: child,
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4)
            )
        ),
      ),);
  }
}
