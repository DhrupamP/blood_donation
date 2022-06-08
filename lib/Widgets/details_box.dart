import 'package:flutter/material.dart';

import '../Size Config/size_config.dart';
import '../constants/color_constants.dart';

class DetailsBox extends StatelessWidget {
  const DetailsBox({Key? key, this.title, this.details}) : super(key: key);
  final String? title;
  final String? details;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.blockSizeVertical! * 9.63,
      width: SizeConfig.blockSizeHorizontal! * 68.33,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: TextStyle(
                color: primaryColor,
                fontSize: SizeConfig.blockSizeHorizontal! * 5,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal! * 3,
          ),
          Text(
            details!,
            style: TextStyle(
              color: primaryText,
              fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
            ),
          ),
        ],
      ),
    );
  }
}
