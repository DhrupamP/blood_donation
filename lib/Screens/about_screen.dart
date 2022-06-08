import 'package:blood_donation/constants/color_constants.dart';
import 'package:flutter/material.dart';

import '../Size Config/size_config.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.blockSizeVertical!;
    var w = SizeConfig.blockSizeHorizontal!;
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Positioned(top: h * 2, left: h * 2, child: const BackButton()),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: h * 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'About Us',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: h * 2.5,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: h * 3.25,
                  ),
                  Image.asset(
                    'assets/nmo.png',
                    width: w * 41.94,
                    height: h * 20.88,
                  ),
                  Text(
                    'NMO LIVE BLOOD DONATION',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: h * 2.6,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
