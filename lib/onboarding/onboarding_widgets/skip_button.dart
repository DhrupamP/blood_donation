import 'package:flutter/material.dart';

import '../../Size Config/size_config.dart';
import '../../constants/color_constants.dart';
import '../../constants/string_constants.dart';

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
