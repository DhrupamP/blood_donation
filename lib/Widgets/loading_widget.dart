import 'package:blood_donation/constants/color_constants.dart';
import 'package:flutter/material.dart';

class MyCircularIndicator extends StatefulWidget {
  const MyCircularIndicator({Key? key}) : super(key: key);

  @override
  _MyCircularIndicatorState createState() => _MyCircularIndicatorState();
}

class _MyCircularIndicatorState extends State<MyCircularIndicator> {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: primaryDesign,
    );
  }
}
