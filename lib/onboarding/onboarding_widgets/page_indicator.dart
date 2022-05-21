import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Size Config/size_config.dart';
import '../../constants/color_constants.dart';

//page indicator
class MyPageIndicator extends StatefulWidget {
  const MyPageIndicator({Key? key, this.controller}) : super(key: key);
  final PageController? controller;
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
        dotWidth: SizeConfig.screenWidth! * 0.023,
        dotHeight: SizeConfig.screenHeight! * 0.0103,
        dotColor: dotColor as Color,
        activeDotColor: primaryDesign as Color,
      ),
    );
  }
}
