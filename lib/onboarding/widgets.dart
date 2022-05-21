import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:blood_donation/constants/color_constants.dart';
import 'package:blood_donation/Size Config/size_config.dart';

import '../constants/string_constants.dart';

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

//on-boarding page
class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    Key? key,
    required this.img,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String img;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Column(
            children: [
              Container(
                child: Image.asset(img),
                height: SizeConfig.screenHeight! * 0.2512,
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.10,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: SizeConfig.screenHeight! * 0.025,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 0,
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: SizeConfig.screenHeight! * 0.015),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//continue button
class ContinueButton extends StatelessWidget {
  const ContinueButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight! * 0.07,
      width: SizeConfig.screenWidth! * 0.8611,
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: Colors.red))),
            backgroundColor: MaterialStateProperty.all(primaryDesign)),
        onPressed: () {},
        child: Text('CONTINUE WITH NUMBER'),
      ),
    );
  }
}

//skip button

class SkipButton extends StatelessWidget {
  const SkipButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: SizeConfig.screenHeight! * 0.05,
          left: SizeConfig.screenWidth! * 0.75),
      child: Text(
        skip,
        style: TextStyle(
          color: primaryDesign,
        ),
      ),
    );
  }
}
