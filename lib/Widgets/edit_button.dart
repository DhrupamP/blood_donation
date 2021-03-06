import 'package:flutter/material.dart';

import '../Size Config/size_config.dart';
import '../constants/color_constants.dart';

class EditButton extends StatelessWidget {
  const EditButton({Key? key, this.hper, this.wper, this.onPressed, this.txt})
      : super(key: key);
  final double? hper;
  final double? wper;
  final VoidCallback? onPressed;
  final String? txt;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical! * hper!,
          left: SizeConfig.blockSizeHorizontal! * wper!),
      child: GestureDetector(
        onTap: onPressed,
        child: Text(
          txt ?? 'Edit',
          style: TextStyle(color: primaryDesign, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
