import 'package:flutter/material.dart';

import '../../Size Config/size_config.dart';

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
        Column(
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
                  fontSize: SizeConfig.screenHeight! * 0.026,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.01,
            ),
            Text(
              subtitle,
              style: TextStyle(fontSize: SizeConfig.screenHeight! * 0.018),
            ),
          ],
        ),
      ],
    );
  }
}
