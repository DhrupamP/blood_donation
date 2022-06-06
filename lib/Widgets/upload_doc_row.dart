import 'package:flutter/material.dart';

import '../Size Config/size_config.dart';
import '../constants/color_constants.dart';

class UploadDocRow extends StatelessWidget {
  const UploadDocRow({Key? key, this.text}) : super(key: key);
  final String? text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.blockSizeVertical! * 8,
      width: SizeConfig.blockSizeHorizontal! * 85,
      child: Row(
        children: [
          Text(
            text!,
            style:
                TextStyle(color: otpCursorColor, fontWeight: FontWeight.w600),
          ),
          Spacer(),
          Container(
            height: SizeConfig.blockSizeVertical! * 8,
            width: SizeConfig.blockSizeVertical! * 8,
            decoration: BoxDecoration(
                color: background, borderRadius: BorderRadius.circular(6)),
            child: Icon(
              Icons.upload_rounded,
              color: secondaryText,
              size: SizeConfig.blockSizeVertical! * 4,
            ),
          )
        ],
      ),
    );
  }
}
