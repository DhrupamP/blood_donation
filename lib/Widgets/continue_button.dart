import 'package:flutter/material.dart';

import '../Size Config/size_config.dart';
import '../constants/color_constants.dart';

//continue button
class ContinueButton extends StatelessWidget {
  const ContinueButton(
      {Key? key,
      this.txt,
      this.bgcolor,
      this.txtColor,
      this.icon,
      this.iconColor,
      this.borderColor,
      this.width,
      this.height,
      this.onpressed})
      : super(key: key);
  final String? txt;
  final Color? bgcolor;
  final Color? txtColor;
  final IconData? icon;
  final Color? iconColor;
  final Color? borderColor;
  final double? height;
  final double? width;
  final VoidCallback? onpressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? SizeConfig.blockSizeVertical! * 7,
      width: width ?? SizeConfig.blockSizeHorizontal! * 86.11,
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              side: BorderSide(
                  width: 1,
                  color: borderColor == null ? primaryDesign! : borderColor!),
              borderRadius: BorderRadius.circular(8.0),
            )),
            backgroundColor: MaterialStateProperty.all(bgcolor)),
        onPressed: onpressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon == null
                ? Container()
                : Icon(
                    icon,
                    color: iconColor,
                  ),
            icon == null
                ? Container()
                : SizedBox(width: SizeConfig.blockSizeHorizontal! * 2),
            Text(
              txt.toString(),
              style: TextStyle(
                  letterSpacing: 0.5,
                  color: txtColor,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeVertical! * 2),
            ),
          ],
        ),
      ),
    );
  }
}
