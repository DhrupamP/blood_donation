import 'package:blood_donation/constants/color_constants.dart';
import 'package:flutter/material.dart';

import '../Size Config/size_config.dart';

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
              height: SizeConfig.blockSizeVertical! * 25.12,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 10,
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal! * 70,
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical! * 2.2,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 1,
                  ),
                  Text(
                    subtitle,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical! * 1.8,
                      color: primaryText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
