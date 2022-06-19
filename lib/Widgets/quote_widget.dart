import 'package:flutter/material.dart';

import '../Size Config/size_config.dart';
import '../constants/color_constants.dart';

class QuoteWidget extends StatelessWidget {
  const QuoteWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal! * 6.9),
      child: SizedBox(
        child: Text(
          "\"A drop of blood can save a life! Don't waste it and donate blood\"",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: quote,
              fontSize: SizeConfig.blockSizeVertical! * 2,
              fontWeight: FontWeight.w800),
        ),
        width: SizeConfig.blockSizeHorizontal! * 77.78,
      ),
    );
  }
}
