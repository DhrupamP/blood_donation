import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Size Config/size_config.dart';
import '../../constants/color_constants.dart';

//page indicator
class MyPageIndicator extends StatefulWidget {
  const MyPageIndicator(
      {Key? key, this.controller, this.dotheight, this.dotwidth})
      : super(key: key);
  final PageController? controller;
  final double? dotwidth;
  final double? dotheight;
  @override
  _MyPageIndicatorState createState() => _MyPageIndicatorState();
}

class _MyPageIndicatorState extends State<MyPageIndicator> {
  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: widget.controller as PageController,
      count: 3,
      effect: WormEffect(
        dotWidth: widget.dotwidth as double,
        dotHeight: widget.dotheight as double,
        dotColor: dotColor!,
        activeDotColor: primaryDesign!,
      ),
    );
  }
}
